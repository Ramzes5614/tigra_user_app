import 'package:tigra/models/log_and_pas.dart';

class RecoveryResponse {
  LoginAndPass loginAndPass;

  RecoveryResponse();

  RecoveryResponse.fromJson(var data)
      : loginAndPass = LoginAndPass.fromJson(data);

  RecoveryResponse.withError() : loginAndPass = LoginAndPass.withError();
}

class RecoveryResponseOk extends RecoveryResponse {
  RecoveryResponseOk(/*var data*/) : super.withError(/*data*/);
}

class RecoveryResponseServerError extends RecoveryResponse {
  RecoveryResponseServerError() : super.withError();
}

class RecoveryResponseCodeError extends RecoveryResponse {
  RecoveryResponseCodeError() : super.withError();
}

class RecoveryResponseCodeChecking extends RecoveryResponse {
  RecoveryResponseCodeChecking() : super.withError();
}

class RecoveryResponseCodeDidNotCome extends RecoveryResponse {
  RecoveryResponseCodeDidNotCome() : super.withError();
}

class RecoveryResponseCodeSended extends RecoveryResponse {
  RecoveryResponseCodeSended() : super.withError();
}

class RecoveryResponseToPhoneEnter extends RecoveryResponse {
  RecoveryResponseToPhoneEnter() : super.withError();
}
/*
  RecoveryResponseOk
  RecoveryResponseServerError
  RecoveryResponseCodeError
  RecoveryResponseCodeChecking
  RecoveryResponseCodeDidNotCome
  RecoveryResponseCodeSended
  RecoveryResponseToPhoneEnter
*/
