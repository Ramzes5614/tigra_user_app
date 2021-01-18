import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:tigra/models/log_and_pas.dart';
import 'package:tigra/repos/app_repository.dart';
import 'package:tigra/responses/user_response.dart';

class UserAuthorisationBloc {
  final AppRepository repository = AppRepository();
  BehaviorSubject<UserResponse> _controller = BehaviorSubject<UserResponse>();
  //UserResponse userResponse;

  /*UserAuthorisationBloc() {
    logInWithLocal();
  }*/

  logIn(LoginAndPass user) async {
    print("Отправляем запрос: ${user.login} : ${user.password}");
    _controller.sink.add(UserLoading());
    UserResponse response =
        await repository.authorisation(user.login, user.password);
    /*if (response.user != null) {
      _controller..sink.add(UserStates.AUTHORISED);
    } else {
      _controller..sink.add(UserStates.NONAUTHORISED);
    }
    this.userResponse = response;*/
    print(response);
    _controller..sink.add(response);
  }

  /*updateUserState(String phoneNumber) async {
    //print("Отправляем запрос: ${user.login} : ${user.password}");
    _controller.sink.add(UserLoading());
    UserResponse response = await repository.updateUserState(phoneNumber);
    /*if (response.user != null) {
      _controller..sink.add(UserStates.AUTHORISED);
    } else {
      _controller..sink.add(UserStates.NONAUTHORISED);
    }
    this.userResponse = response;*/
    print(response);
    _controller..sink.add(response);
  }*/

  logInWithLocal() async {
    _controller.sink.add(UserLoading());
    UserResponse response = await repository.localAuthorisation();
    /*if (response.user != null) {
      _controller..sink.add(UserStates.AUTHORISED);
    } else {
      _controller..sink.add(UserStates.NONAUTHORISED);
    }
    this.userResponse = response;*/
    _controller..sink.add(response);
  }

  pickState(UserResponse response) {
    _controller..sink.add(response);
  }

  logOut() async {
    UserResponse response = await repository.logout();
    _controller.sink.add(response);
    //this.userResponse = response;
  }

  BehaviorSubject<UserResponse> get subject => _controller;
  //UserResponse get user => userResponse;

  dispose() {
    _controller.close();
  }
}
