import 'package:tigra/models/log_and_pas.dart';

class RecoveryResponse {
  LoginAndPass loginAndPass;
  String error;

  RecoveryResponse();

  RecoveryResponse.fromJson(var data)
      : loginAndPass = LoginAndPass.fromJson(data);

  RecoveryResponse.withError(String err)
      : loginAndPass = LoginAndPass.withError(),
        error = err;
}

class RecoveryResponseOk extends RecoveryResponse {
  RecoveryResponseOk() : super();
}

class RecoveryResponseServerError extends RecoveryResponse {
  RecoveryResponseServerError(String error) : super.withError(error);
}

class RecoveryResponseCodeChecking extends RecoveryResponse {
  RecoveryResponseCodeChecking() : super();
}

class RecoveryResponseCodeDidNotCome extends RecoveryResponse {
  RecoveryResponseCodeDidNotCome() : super();
}

class RecoveryResponseCodeSended extends RecoveryResponse {
  RecoveryResponseCodeSended() : super();
}

class RecoveryResponseToPhoneEnter extends RecoveryResponse {
  RecoveryResponseToPhoneEnter() : super();
}

class RecoveryResponsePassChanged extends RecoveryResponse {
  RecoveryResponsePassChanged() : super();
}
/*
  RecoveryResponseOk
  RecoveryResponseServerError
  RecoveryResponseCodeError
  RecoveryResponseCodeChecking
  RecoveryResponseCodeDidNotCome
  RecoveryResponseCodeSended
  RecoveryResponseToPhoneEnter
  RecoveryResponsePassChanged
*/
