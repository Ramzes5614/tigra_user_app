import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Tigra/elements/methods.dart';
import 'package:Tigra/models/user_model.dart';
import 'package:Tigra/responses/recovery_response.dart';
import 'package:Tigra/responses/user_response.dart';
import 'package:dio/dio.dart';

class AppRepository {
  Dio _dio = Dio();

  /*Авторизация через сервер*/
  Future<UserResponse> authorisation(String login, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String basicAuth =
          'Basic ' + base64.encode(utf8.encode("$login:$password"));
      print(basicAuth);
      var response = await _dio.get(
          "https://kids-project-pro.herokuapp.com/account/login/",
          options: Options(
            headers: {'authorization': basicAuth},
          ));
      var jdata = jsonEncode(response.data);
      var data = jsonDecode(jdata);
      if (data != null) {
        String isAuth = data["authorized"];
        if (isAuth == "true") {
          prefs.setString("phone_number", login);
          prefs.setString("first_name", data["profile"]["first_name"]);
          prefs.setString("last_name", data["profile"]["last_name"]);
          prefs.setInt("visit_counter", data["profile"]["visit_counter"]);
          prefs.setString("password", password);
          print("Вход осуществлен");
          return UserLoggedIn({
            "first_name": data["profile"]["first_name"],
            "last_name": data["profile"]["last_name"],
            "phone_number": data["profile"]["phone_number"],
            "middle_name": data["profile"]["child_name"],
            "password": password,
            "visit_counter": data["profile"]["visit_counter"]
          });
        } else {
          return UserAuthFailed();
        }
      } else {
        return UserWithError("Ошибка сервера...");
      }
    } catch (error, stck) {
      print("$error $stck");
      return UserWithError("Ошибка $error");
    }
  }

  /*Авторизация через локальный shared preferences
  берется локальный логин и пароль, затем шлется запрос авторизации*/
  Future<UserResponse> localAuthorisation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String login = prefs.getString("phone_number");
    String password = prefs.getString("password");
    try {
      if (login != null && password != null) {
        try {
          String basicAuth =
              'Basic ' + base64.encode(utf8.encode("$login:$password"));
          print(basicAuth);
          var response = await _dio.get(
              "https://kids-project-pro.herokuapp.com/account/login/",
              options: Options(
                headers: {'authorization': basicAuth},
              ));
          var jdata = jsonEncode(response.data);
          var data = jsonDecode(jdata);
          if (data != null) {
            String isAuth = data["authorized"];
            if (isAuth == "true") {
              prefs.setString("phone_number", login);
              prefs.setString("first_name", data["profile"]["first_name"]);
              prefs.setString("last_name", data["profile"]["last_name"]);
              prefs.setInt("visit_counter", data["profile"]["visit_counter"]);
              prefs.setString("password", password);
              print(data["profile"]["visit_counter"]);
              print("Вход осуществлен");
              return UserLoggedIn({
                "first_name": data["profile"]["first_name"],
                "last_name": data["profile"]["last_name"],
                "phone_number": data["profile"]["phone_number"],
                "middle_name": data["profile"]["child_name"],
                "password": password,
                "visit_counter": data["profile"]["visit_counter"]
              });
            } else {
              return UserAuthFailed();
            }
          } else {
            return UserWithError("Ошибка сервера...");
          }
        } catch (error, stck) {
          print("$error $stck");
          return UserWithError("Ошибка $error");
        }
      } else {
        return UserUnAuth();
      }
    } catch (error, stacktrase) {
      print("$error  $stacktrase");
      return UserUnAuth();
    }
  }

  /*Регистрация нового аккаунта
   Принимает пользователя и сохраняет его данные до проверки кода*/
  Future<int> registrate(UserModel user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String _pNumber = convertToSimplePhoneNumber(user.userPhoneNumber);
      print(_pNumber);
      var response = await _dio.get(
          "https://kids-project-pro.herokuapp.com/verify/time_based/$_pNumber");
      if (response.statusCode != 200) {
        return -1;
      }
      print(response);
      var jdata = jsonEncode(response.data);
      if (jdata is String && jdata == '"Phone number already exists"') {
        return -2;
      }
      var data = jsonDecode(jdata);
      if (data != null) {
        if (data["Responded"]["success"] != false) {
          prefs.setString("reg_user_name", user.name);
          prefs.setString("reg_user_surname", user.surname);
          prefs.setString("reg_user_middleName", user.middlename);
          prefs.setString("reg_user_phone_number", user.userPhoneNumber);
          prefs.setString("reg_user_password", user.password);
          prefs.setString("OTPReg", data["OTP"]);
          return 0;
        } else {
          return -1;
        }
      } else {
        return -1;
      }
    } catch (error, stck) {
      print("$error $stck");
      return -1;
    }
  }

  ///Проверяет есть ли пользовательские данные в shared
  ///и возвращает 0 - если есть, иначе - 1
  Future<int> ifHasUserRegistrationData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var name = prefs.getString("reg_user_name");
      var surname = prefs.getString("reg_user_surname");
      var middleName = prefs.getString("reg_user_middleName");
      var phoneNumber = prefs.getString("reg_user_phone_number");
      var password = prefs.getString("reg_user_password");
      var regOtp = prefs.getString("OTPReg");
      if (name != null &&
          surname != null &&
          middleName != null &&
          phoneNumber != null &&
          password != null &&
          regOtp != null) {
        return 0;
      } else {
        return -1;
      }
    } catch (error, stck) {
      print("$error $stck");
      return -1;
    }
  }

  ///Сверяет введенный код с тем, что было сохранено после запроса на отправку кода
  ///0 если все ок
  ///-2 - код неверный
  ///-1 - ошибка
  Future<int> registrationCodeCheck(String otp) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var name = prefs.getString("reg_user_name");
      var surname = prefs.getString("reg_user_surname");
      var middleName = prefs.getString("reg_user_middleName");
      var phoneNumber = prefs.getString("reg_user_phone_number");
      var password = prefs.getString("reg_user_password");
      var regOtp = prefs.getString("OTPReg");
      if (name != null &&
          surname != null &&
          middleName != null &&
          phoneNumber != null &&
          password != null &&
          regOtp != null) {
        if (otp == regOtp) {
          /*Код правильный отправляем запрос*/
          try {
            String newStr = convertToSimplePhoneNumber(phoneNumber);
            print(newStr);
            var response = await _dio.post(
                "https://kids-project-pro.herokuapp.com/verify/time_based/$newStr/",
                data: FormData.fromMap({
                  'otp': regOtp,
                  'first_name': name,
                  'last_name': surname,
                  'password': password,
                  'child_name': middleName
                }));
            print(response);
            if (response.statusCode != 200) {
              return -1;
            }
            var jdata = jsonEncode(response.data);
            print(jdata);
            if (jdata is String && jdata == '"OTP is wrong/expired"') {
              return -2;
            } else {
              return 0;
            }
          } catch (error, stck) {
            print("$error $stck");
            return -1;
          }
        } else {
          /*Код неверный, возврат*/
          return -2;
        }
      } else
        return -1;
    } catch (error, stck) {
      print("$error $stck");
      return -1;
    }
  }

  ///Возвращает пользователя если его данные были сохранены в ходе регистрации в
  ///shared prefs
  Future<UserResponse> getUserFromLocalRegistration() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var name = prefs.getString("reg_user_name");
      var surname = prefs.getString("reg_user_surname");
      var middleName = prefs.getString("reg_user_middleName");
      var phoneNumber = prefs.getString("reg_user_phone_number");
      var password = prefs.getString("reg_user_password");
      var regOtp = prefs.getString("OTPReg");
      if (name != null &&
          surname != null &&
          middleName != null &&
          phoneNumber != null &&
          password != null &&
          regOtp != null) {
        return UserLoggedIn({
          "first_name": name,
          "last_name": surname,
          "middle_name": middleName,
          "phone_number": phoneNumber,
          "password": password,
          "visit_counter": 0
        });
      } else
        return UserUnAuth();
    } catch (error, stck) {
      print("$error $stck");
      return UserUnAuth();
    }
  }

  ///Выход из аккаунта
  Future<UserResponse> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("phone_number");
    prefs.remove("first_name");
    prefs.remove("last_name");
    prefs.remove("visit_counter");
    prefs.remove("password");
    return UserUnAuth();
  }

  ///Обновление данных
  Future<int> updateUserState(String phoneNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      /*String basicAuth = 'Basic ' +
          base64.encode(utf8.encode("${user.userPhoneNumber}:${user.}"));
      print(basicAuth);*/
      String _pNumber = convertToSimplePhoneNumber(phoneNumber);
      var response = await _dio.get(
        "https://kids-project-pro.herokuapp.com/account/visits/$_pNumber",
      );
      print(response.data);
      var jdata = jsonEncode(response.data);
      var data = jsonDecode(jdata);
      print(jdata);
      if (data != null) {
        prefs.setInt("visits_counter", data["visits"]);
        print("Вход осуществлен");
        return data["visits"];
      } else {
        return -1;
      }
    } catch (error, stck) {
      print("$error $stck");
      return -1;
    }
  }

  ///Проверка кода
  Future<RecoveryResponse> codeCheck(String phoneNumber, String code) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String sendedOTP = prefs.getString("otp");
      if (code == sendedOTP) {
        String newStr = convertToSimplePhoneNumber(phoneNumber);
        var response = await _dio.post(
            "https://kids-project-pro.herokuapp.com/verify/confirm_phone/$newStr",
            data: FormData.fromMap({'otp': code}));
        print(response);
        var jdata = jsonEncode(response.data);
        print(jdata);
        if (response.statusCode != 200) {
          return RecoveryResponseServerError("Связь с сервером потеряна");
        }
        if (jdata == '"Phone number found"') {
          return RecoveryResponseOk();
        } else {
          return RecoveryResponseCodeError("Код неверный");
        }
      } else {
        return RecoveryResponseCodeError("Код неверный");
      }
    } catch (error, stck) {
      print("$error $stck");
      return RecoveryResponseServerError(error.toString()); /*"Ошибка $error"*/
    }
  }

  Future<RecoveryResponse> sendCode(String phoneNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int count;
    DateTime _time;
    try {
      count = prefs.getInt("count_send") ?? 0;

      ///Проверка количества и времени отправок перед запросом
      ///Если было больше 3 запросов за последние 2 часа - возврат сообщения
      ///Иначе - продолжает запрос на отправку кода
      int _lastTime = prefs.getInt("last_time_send") ??
          DateTime.now().millisecondsSinceEpoch;
      int _count = prefs.getInt("count_send");
      DateTime _lastResp = DateTime.fromMillisecondsSinceEpoch(_lastTime);
      if (_lastTime != null && _count != null) {
        if (_count >= 3 && (DateTime.now().difference(_lastResp).inHours < 2)) {
          return RecoveryResponseServerError(
              "Слишком много попыток, повторите позже");
        }
      }
    } catch (error) {
      count = 0;
    }
    print("Последнее время отправки - $_time");
    print("Кол-во - $count");
    try {
      String newStr = convertToSimplePhoneNumber(phoneNumber);
      var response = await _dio.get(
        "https://kids-project-pro.herokuapp.com/verify/confirm_phone/$newStr",
      );
      print(response);
      var jdata = jsonEncode(response.data);
      var data = jsonDecode(jdata);
      print(jdata);
      if (response.statusCode != 200) {
        return RecoveryResponseServerError("Связь с сервером потеряна");
      }
      if (jdata is String && jdata == '"Phone number is not registered"') {
        return RecoveryResponseServerError("Номер телефона не найден");
      }
      if (data["Responded"]["success"] != false) {
        count++;
        prefs.setString("otp", data["OTP"]);
        prefs.setInt("last_time_send", DateTime.now().millisecondsSinceEpoch);
        prefs.setInt("count_send", count);
        print("Вход осуществлен");
        return RecoveryResponseCodeSended();
      } else {
        return RecoveryResponseServerError(
            data["Responded"]["message"]); /*"Ошибка сервера..."*/
      }
    } catch (error, stck) {
      print("$error $stck");
      return RecoveryResponseServerError(error.toString()); /*"Ошибка $error"*/
    }
  }

  Future<RecoveryResponse> changePassword(
      String phoneNumber, String pass) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String newStr = convertToSimplePhoneNumber(phoneNumber);
      var response;
      try {
        response = await _dio.post(
            "https://kids-project-pro.herokuapp.com/verify/reset_password/$newStr",
            data: FormData.fromMap({'password': pass}));
      } catch (error) {}
      print(response);
      var jdata = jsonEncode(response.data);
      print(jdata);
      if (response.statusCode != 200) {
        return RecoveryResponseServerError("Связь с сервером потеряна");
      }
      if (jdata == '"Password changed successfully"') {
        prefs.remove("otp");
        prefs.remove("last_time_send");
        prefs.remove("count_send");
        return RecoveryResponsePassChanged();
      } else {
        return RecoveryResponseServerError("Код неверный");
      }
    } catch (error, stck) {
      print("$error $stck");
      return RecoveryResponseServerError(error.toString()); /*"Ошибка $error"*/
    }
  }
}
