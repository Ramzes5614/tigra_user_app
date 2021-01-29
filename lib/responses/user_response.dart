import 'package:tigra/models/user_model.dart';

class UserResponse {
  UserModel user;
  String error;

  /*UserResponse(){
    user = null;
    error = "";
  }*/
  UserResponse(var data) {
    if (data != null) {
      user = UserModel.fromJson(data);
      error = "";
    } else {
      UserResponse.withError("Не авторизован");
    }
  }

  UserResponse.fromJson(var data)
      : user = UserModel.fromJson(data),
        error = "";

  /*UserResponse.fromLocal(
      String firtName, String lastName, String phoneNumber, int visits)
      : user = UserModel.fromLocal(firtName, lastName, phoneNumber, visits),
        error = "";*/

  UserResponse.withError(String err)
      : user = null,
        error = err;
}

class UserLoggedIn extends UserResponse {
  UserLoggedIn(var data) : super(data);
}

class UserUnAuth extends UserResponse {
  UserUnAuth() : super(null);
}

class ToAuthScr extends UserResponse {
  ToAuthScr() : super(null);
}

class ToRegScr extends UserResponse {
  ToRegScr() : super(null);
}

class UserLoading extends UserResponse {
  UserLoading() : super(null);
}

class UserAuthFailed extends UserResponse {
  UserAuthFailed() : super(null);
}

class UserWithError extends UserResponse {
  UserWithError(String err) : super.withError(err);
}

class UserToQrScreen extends UserLoggedIn {
  UserToQrScreen(var data) : super(data);
}

class UserToHelp extends UserResponse {
  UserToHelp() : super(null);
}
