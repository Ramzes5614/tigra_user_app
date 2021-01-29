import 'package:rxdart/rxdart.dart';
import 'package:Tigra/repos/app_repository.dart';
import 'package:Tigra/responses/recovery_response.dart';

class RecoveryBloc {
  final AppRepository _repository = AppRepository();
  BehaviorSubject<RecoveryResponse> _controller =
      BehaviorSubject<RecoveryResponse>();

  String _phone = "";

  RecoveryResponse _lastResponse = RecoveryResponseToPhoneEnter();

  BehaviorSubject<RecoveryResponse> get subject => _controller;

  RecoveryResponse get last => _lastResponse;

  RecoveryResponse get defaultItem => RecoveryResponseToPhoneEnter();

  codeCheck(String pgone, String code) async {
    _controller.sink.add(RecoveryResponseCodeChecking());
    RecoveryResponse response = await _repository.codeCheck(pgone, code);
    _controller.sink.add(response);
    if (!(response is RecoveryResponseServerError)) {
      _lastResponse = response;
    }
  }

  sendCode(String phoneNumber) async {
    _phone = phoneNumber;
    _controller.sink.add(RecoveryResponseCodeChecking());
    RecoveryResponse response = await _repository.sendCode(phoneNumber);
    _controller.sink.add(response);
    if (!(response is RecoveryResponseServerError)) {
      _lastResponse = response;
    }
  }

  changePass(String phoneNumber, String pass) async {
    _controller.sink.add(RecoveryResponseCodeChecking());
    RecoveryResponse response =
        await _repository.changePassword(phoneNumber, pass);
    _controller.sink.add(response);
    if (!(response is RecoveryResponseServerError)) {
      _lastResponse = response;
    }
  }

  pickState(RecoveryResponse response) {
    _controller.sink.add(response);
    if (!(response is RecoveryResponseServerError)) {
      _lastResponse = response;
    }
  }

  didNotCame() async {
    if (_phone == "") {
      print("нету номера телефона");
      return;
    }
    RecoveryResponse response = await _repository.sendCode(_phone);
    _controller.sink.add(response);
    if (!(response is RecoveryResponseServerError)) {
      _lastResponse = response;
    }
  }

  dispose() {
    _controller.close();
  }
}
