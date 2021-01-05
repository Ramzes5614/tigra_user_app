import 'dart:async';

import 'package:tigra/repos/app_repository.dart';
import 'package:tigra/responses/user_response.dart';

class UserAuthorisationBloc {
  final AppRepository repository = AppRepository();
  StreamController<UserResponse> _controller =
      StreamController<UserResponse>.broadcast();

  logIn(String login, String password) async {
    UserResponse userResponse = await repository.authorisation(login, password);
    _controller.sink.add(userResponse);
  }

  logOut() {}
}
