import 'package:rxdart/rxdart.dart';
import 'package:Tigra/main.dart';
import 'package:Tigra/models/user_model.dart';
import 'package:Tigra/repos/app_repository.dart';
import 'package:Tigra/responses/user_response.dart';

enum REGSTATE {
  TOREGSCR,
  CODESENDED,
  LOADING,
  CODECHECKED,
  ERROR,
  CODEERROR,
  ALREADYEXIST,
  NOUSER
}

class RegistrationBloc {
  final AppRepository _repository = AppRepository();
  BehaviorSubject<REGSTATE> _controller = BehaviorSubject<REGSTATE>();

  BehaviorSubject<REGSTATE> get subject => _controller;

  REGSTATE get defaultItem => REGSTATE.TOREGSCR;

  UserModel _user;

  pickItem(REGSTATE item) {
    _controller.sink.add(item);
  }

  registrate(UserModel user) async {
    _user = user;
    print(
        "Отправляем запрос: ${user.surname} ${user.name}, ${user.userPhoneNumber}");
    _controller.sink.add(REGSTATE.LOADING);
    int response = await _repository.registrate(user);
    print(response);
    if (response == 0) {
      _controller..sink.add(REGSTATE.CODESENDED);
    } else if (response == -2) {
      _controller.sink.add(REGSTATE.ALREADYEXIST);
    } else {
      _controller.sink.add(REGSTATE.ERROR);
    }
  }

  Future<bool> hasUserData() async {
    int response = await _repository.ifHasUserRegistrationData();
    print(response);
    if (response == 0) {
      return true;
    } else {
      _controller.sink.add(REGSTATE.NOUSER);
      return false;
    }
  }

  codeCheck(String otp) async {
    _controller.sink.add(REGSTATE.LOADING);
    if (!(await hasUserData())) {
      _controller.sink.add(REGSTATE.ERROR);
      return;
    }
    var response = await _repository.registrationCodeCheck(otp);
    if (response == 0) {
      //_controller.sink.add(REGSTATE.CODECHECKED);
      UserResponse user = await _repository.getUserFromLocalRegistration();
      authorisationBloc.pickState(user);
    } else if (response == -2) {
      _controller.sink.add(REGSTATE.CODEERROR);
    } else {
      _controller.sink.add(REGSTATE.ERROR);
    }
  }

  didNotCame() async {
    if (_user == null) {
      return;
    }
    int response = await _repository.registrate(_user);
    print(response);
    if (response == 0) {
      _controller..sink.add(REGSTATE.CODESENDED);
    } else if (response == -2) {
      _controller.sink.add(REGSTATE.ALREADYEXIST);
    } else {
      _controller.sink.add(REGSTATE.ERROR);
    }
  }

  dispose() {
    _controller.close();
  }
}
