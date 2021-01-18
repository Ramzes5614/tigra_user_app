import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tigra/blocs/recovary_bloc.dart';
import 'package:tigra/elements/methods.dart';
import 'package:tigra/models/user_model.dart';
import 'package:tigra/responses/recovery_response.dart';
import 'package:tigra/responses/user_response.dart';
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
        if (isAuth != "false") {
          prefs.setString("first_name", data["profile"]["first_name"]);
          prefs.setString("last_name", data["profile"]["last_name"]);
          prefs.setInt("visits_counter", data["profile"]["visits_counter"]);
          prefs.setString("phone_number", login);
          prefs.setString("password", password);
          print("Вход осуществлен");
          return UserLoggedIn(data["profile"]);
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

  /*Авторизация через локальный shared preferences*/
  Future<UserResponse> localAuthorisation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String login = prefs.getString("phone_number");
    String firstName = prefs.getString("first_name");
    String lastName = prefs.getString("last_name");
    int visitsCount = prefs.getInt("visits_counter");
    try {
      if (login != null &&
          firstName != null &&
          lastName != null &&
          visitsCount != null) {
        var data = {
          "first_name": firstName,
          "last_name": lastName,
          "phone_number": login,
          "visits_counter": visitsCount
        };
        return UserLoggedIn(data);
      } else {
        return UserUnAuth();
      }
    } catch (error, stacktrase) {
      print("$error  $stacktrase");
      return UserUnAuth();
    }
  }

  /*Выход из аккаунта*/
  Future<UserResponse> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("phone_number");
    prefs.remove("first_name");
    prefs.remove("last_name");
    prefs.remove("visits_counter");
    prefs.remove("password");
    return UserUnAuth();
  }

  /*Обновление данных*/
  Future<UserResponse> updateUserState(String phoneNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      /*String basicAuth = 'Basic ' +
          base64.encode(utf8.encode("${user.userPhoneNumber}:${user.}"));
      print(basicAuth);*/
      String newStr = convertToSimplePhoneNumber(phoneNumber);
      var response = await _dio.get(
        "https://kids-project-pro.herokuapp.com/account/visits/$newStr",
      );
      print(response.data);
      var jdata = jsonEncode(response.data);
      var data = jsonDecode(jdata);
      print(jdata);
      if (data != null) {
        //prefs.setString("first_name", data["profile"]["first_name"]);
        //prefs.setString("last_name", data["profile"]["last_name"]);
        prefs.setInt("visits_counter", data["profile"]["visits"]);
        //prefs.setString("phone_number", login);
        //prefs.setString("password", password);
        print("Вход осуществлен");
        return UserLoggedIn(data["profile"]);
      } else {
        return UserWithError("Ошибка сервера...");
      }
    } catch (error, stck) {
      print("$error $stck");
      return UserWithError("Ошибка $error");
    }
  }

  /*Проверка кода */
  Future<RecoveryResponse> codeCheck(String phoneNumber, String code) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
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
        return RecoveryResponseServerError("Код неверный");
      }
      /*if (data["Responded"]["success"] != false) {
        print("");
        return RecoveryResponseCodeSended();
      } else {
        return RecoveryResponseServerError(
            data["Responded"]["message"]); /*"Ошибка сервера..."*/
      }*/
    } catch (error, stck) {
      print("$error $stck");
      return RecoveryResponseServerError(error.toString()); /*"Ошибка $error"*/
    }
    //return Future.delayed(Duration(seconds: 1), () => RecoveryResponseOk());
  }

  Future<bool> codeCheckBool(String phoneNumber, String code) async {
    try {
      String newStr = convertToSimplePhoneNumber(phoneNumber);
      var response = await _dio.post(
          "https://kids-project-pro.herokuapp.com/verify/confirm_phone/$newStr",
          data: FormData.fromMap({'otp': code}));
      print(response);
      var jdata = jsonEncode(response.data);
      print(jdata);
      if (response.statusCode != 200) {
        return false;
      }
      if (jdata == '"Phone number found"') {
        return true;
      } else {
        return false;
      }
      /*if (data["Responded"]["success"] != false) {
        print("");
        return RecoveryResponseCodeSended();
      } else {
        return RecoveryResponseServerError(
            data["Responded"]["message"]); /*"Ошибка сервера..."*/
      }*/
    } catch (error, stck) {
      print("$error $stck");
      return false;
    }
  }

  Future<RecoveryResponse> sendCode(String phoneNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int count;
    DateTime _time;
    try {
      _time = DateTime.parse(prefs.getString("last_time_send"));
      count = prefs.getInt("count_send");
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
      if (jdata == '"Phone number is not registered"') {
        return RecoveryResponseServerError("Номер телефона не найден");
      }
      if (response.statusCode != 200) {
        return RecoveryResponseServerError("Связь с сервером потеряна");
      }
      if (data["Responded"]["success"] != false) {
        count++;
        prefs.setString("otp", data["OTP"]);
        prefs.setString("last_time_send", data["Responded"]["data"]);
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
        return RecoveryResponsePassChanged();
      } else {
        return RecoveryResponseServerError("Код неверный");
      }
      /*if (data["Responded"]["success"] != false) {
        print("");
        return RecoveryResponseCodeSended();
      } else {
        return RecoveryResponseServerError(
            data["Responded"]["message"]); /*"Ошибка сервера..."*/
      }*/
    } catch (error, stck) {
      print("$error $stck");
      return RecoveryResponseServerError(error.toString()); /*"Ошибка $error"*/
    }
    /*return Future.delayed(
        Duration(seconds: 1), () => RecoveryResponsePassChanged());*/
  }
}
