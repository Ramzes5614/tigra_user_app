import 'package:tigra/models/user_model.dart';

class UserResponse {
  final UserModel user;
  final String error;

  UserResponse.fromJson(var data)
      : user = UserModel.fromJson(data),
        error = "";

  UserResponse.fromLocal(
      String firtName, String lastName, String phoneNumber, int visits)
      : user = UserModel.fromLocal(firtName, lastName, phoneNumber, visits),
        error = "";

  UserResponse.withError(String err)
      : user = null,
        error = err;
}
