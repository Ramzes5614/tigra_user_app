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

  Future<RecoveryResponseOk> codeCheck() {
    return Future.delayed(Duration(seconds: 1), () => RecoveryResponseOk());
  }

  Future<RecoveryResponseCodeSended> sendCode() {
    return Future.delayed(
        Duration(seconds: 1), () => RecoveryResponseCodeSended());
  }
}
