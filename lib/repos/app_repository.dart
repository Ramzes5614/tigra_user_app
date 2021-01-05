import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tigra/responses/user_response.dart';
import 'package:dio/dio.dart';

class AppRepository {
  Dio _dio = Dio();
  Future<UserResponse> authorisation(String login, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var parametrs = {"login": "$login", "password": "$password"};
    Response response = await _dio.post(
        "https://kids-project-pro.herokuapp.com/account/login/",
        queryParameters: parametrs);
    var data = jsonDecode(response.data);
    if (data.isNotEmpty) {
      bool isAuth = data["authorised"];
      if (isAuth) {
        prefs.setString("login", login);
        prefs.setString("password", password);
        return UserResponse.example();
      } else {
        return UserResponse.withError("Пользователь не найден");
      }
    } else {
      return UserResponse.withError(
          "Произошла ошибка при подключении к серверу");
    }
  }
}
