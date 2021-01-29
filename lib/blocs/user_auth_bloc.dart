import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:tigra/models/log_and_pas.dart';
import 'package:tigra/models/user_model.dart';
import 'package:tigra/repos/app_repository.dart';
import 'package:tigra/responses/user_response.dart';

class UserAuthorisationBloc {
  final AppRepository repository = AppRepository();
  BehaviorSubject<UserResponse> _controller = BehaviorSubject<UserResponse>();

  //Registration
  /*registrate(UserModel user) async {
    print("Отправляем запрос: ${user.surname} ${user.name}, ${user.userPhoneNumber}");
    _controller.sink.add(UserLoading());
    UserResponse response =
        await repository.registrate(user);
    print(response);
    _controller..sink.add(response);
  }*/

  logIn(LoginAndPass user) async {
    print("Отправляем запрос: ${user.login} : ${user.password}");
    _controller.sink.add(UserLoading());
    UserResponse response =
        await repository.authorisation(user.login, user.password);
    print(response);
    _controller..sink.add(response);
  }

  updateUserState(UserModel user) async {
    _controller.sink.add(UserLoading());
    int response = await repository.updateUserState(user.userPhoneNumber);
    print(response);
    if (response != -1) {
      _controller.sink.add(UserLoggedIn({
        "first_name": user.name,
        "last_name": user.surname,
        "phone_number": user.userPhoneNumber,
        "middle_name": user.middlename,
        "password": user.password,
        "visit_counter": response
      }));
    } else {
      return UserLoggedIn({
        "first_name": user.name,
        "last_name": user.surname,
        "phone_number": user.userPhoneNumber,
        "middle_name": user.middlename,
        "password": user.password,
        "visit_counter": user.visits
      });
    }
  }

  logInWithLocal() async {
    _controller.sink.add(UserLoading());
    UserResponse response = await repository.localAuthorisation();
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
