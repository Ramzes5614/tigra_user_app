import 'package:rxdart/rxdart.dart';
import 'package:tigra/repos/app_repository.dart';
import 'package:tigra/responses/recovery_response.dart';
import 'package:tigra/responses/user_response.dart';

class RecoveryBloc {
  final AppRepository _repository = AppRepository();
  BehaviorSubject<RecoveryResponse> _controller =
      BehaviorSubject<RecoveryResponse>();

  RecoveryResponse _lastResponse = RecoveryResponseToPhoneEnter();

  BehaviorSubject<RecoveryResponse> get subject => _controller;

  RecoveryResponse get last => _lastResponse;

  RecoveryResponse get defaultItem => RecoveryResponseToPhoneEnter();

  codeCheck(String code) async {
    _controller.sink.add(RecoveryResponseCodeChecking());
    RecoveryResponse response = await _repository.codeCheck();
    _controller.sink.add(response);
    _lastResponse = response;
  }

  sendCode(String phoneNumber) async {
    RecoveryResponse response = await _repository.sendCode();
    _controller.sink.add(response);
    _lastResponse = response;
  }

  pickState(RecoveryResponse response) {
    _controller.sink.add(response);
    _lastResponse = response;
  }

  dispose() {
    _controller.close();
  }
}
