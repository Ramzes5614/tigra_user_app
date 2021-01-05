import 'package:tigra/models/user_model.dart';

class UserResponse {
  final UserModel user;
  final String error;

  UserResponse.fromJson(var data)
      : user = UserModel.fromJson(),
        error = "";

  UserResponse.example()
      : user = UserModel.fromJson(),
        error = "";

  UserResponse.withError(String err)
      : user = null,
        error = err;
}
