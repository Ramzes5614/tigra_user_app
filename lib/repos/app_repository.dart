import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
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
          return UserResponse.fromJson(data);
        } else {
          return UserResponse.withError("Пользователь не найден");
        }
      } else {
        return UserResponse.withError(
            "Произошла ошибка при подключении к серверу");
      }
    } catch (error, stck) {
      print("$error $stck");
      return UserResponse.withError("Ошибка $error");
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
        return UserResponse.fromLocal(firstName, lastName, login, visitsCount);
      } else {
        return UserResponse.withError("Пользователь не найден");
      }
    } catch (error, stacktrase) {
      print("$error  $stacktrase");
      return UserResponse.withError("Ошибка");
    }
  }

  /*Выход из аккаунта*/
  Future<UserResponse> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("phone_number");
    prefs.getString("first_name");
    prefs.getString("last_name");
    prefs.getInt("visits_counter");
    prefs.getInt("password");
  }
}
