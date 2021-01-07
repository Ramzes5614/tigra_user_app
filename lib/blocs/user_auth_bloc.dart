import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:tigra/repos/app_repository.dart';
import 'package:tigra/responses/user_response.dart';

enum UserStates { AUTHORISED, NONAUTHORISED, UNINITIALISED }

class UserAuthorisationBloc {
  final AppRepository repository = AppRepository();
  BehaviorSubject<UserStates> _controller = BehaviorSubject<UserStates>();

  logIn(String login, String password) async {
    UserResponse userResponse = await repository.authorisation(login, password);
    if (userResponse.user != null) {
      _controller..sink.add(UserStates.AUTHORISED);
    } else {
      _controller..sink.add(UserStates.NONAUTHORISED);
    }
  }

  logInWithLocal() async {
    UserResponse userResponse = await repository.localAuthorisation();
    if (userResponse.user != null) {
      _controller..sink.add(UserStates.AUTHORISED);
    } else {
      _controller..sink.add(UserStates.NONAUTHORISED);
    }
  }

  pickState(UserStates state) {
    _controller..sink.add(state);
  }

  logOut() {}

  BehaviorSubject<UserStates> get subject => _controller;

  dispose() {
    _controller.close();
  }
}
