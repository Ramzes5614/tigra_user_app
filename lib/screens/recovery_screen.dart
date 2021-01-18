import 'package:flutter/material.dart';
import 'package:tigra/blocs/recovary_bloc.dart';
import 'package:tigra/elements/loading_spinkit.dart';
import 'package:tigra/responses/recovery_response.dart';
import 'package:tigra/styles/theme.dart';
import 'package:tigra/widgets/pass_changing.dart';
import 'package:tigra/widgets/recovery_code_enter_widget.dart';
import 'package:tigra/widgets/recovery_phone_enter_widget.dart';

class RecoveryScreen extends StatefulWidget {
  @override
  _RecoveryScreen createState() => _RecoveryScreen();
}

class _RecoveryScreen extends State<RecoveryScreen> {
  TextEditingController _controller = TextEditingController();
  String _phoneNumber = "";

  TextEditingController _firstPassController = TextEditingController();
  TextEditingController _secondPassController = TextEditingController();

  RecoveryBloc recoveryBloc = RecoveryBloc();
  String _btnText = "Далее";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          /*Сделать проверку кол-ва запросов на отправление пароля*/
          if (recoveryBloc.last is RecoveryResponseCodeSended) {
            recoveryBloc.pickState(RecoveryResponseToPhoneEnter());
          } else if (recoveryBloc.last is RecoveryResponseToPhoneEnter) {
            Navigator.pop(context);
          } else if (recoveryBloc.last is RecoveryResponseOk) {
            _btnText = "Далее";
            recoveryBloc.pickState(RecoveryResponseCodeSended());
          }
          return null;
        },
        child: Scaffold(
          body: Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: Text(
                    "Восстановить пароль",
                    style: kTitleTextStyle,
                  ),
                ),
                StreamBuilder(
                  initialData: recoveryBloc.defaultItem,
                  stream: recoveryBloc.subject.stream,
                  builder: (context, AsyncSnapshot<RecoveryResponse> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data is RecoveryResponseToPhoneEnter) {
                        return PhoneEnterContainer(_controller);
                      } else if (snapshot.data is RecoveryResponseCodeSended) {
                        return CodeEnterWidget(
                            codeController: _controller,
                            key: keys.formLoginKeys[9]);
                      } else if (snapshot.data
                          is RecoveryResponseCodeChecking) {
                        return loadingSpinkit();
                      } else if (snapshot.data is RecoveryResponseOk) {
                        return PassChangeContainer(keys.formLoginKeys[1],
                            _firstPassController, _secondPassController);
                      } else if (snapshot.data is RecoveryResponsePassChanged) {
                        Navigator.pop(context);
                      }
                    }
                    return PhoneEnterContainer(_controller);
                  },
                ),
                StreamBuilder<RecoveryResponse>(
                    stream: recoveryBloc.subject.stream,
                    builder:
                        (context, AsyncSnapshot<RecoveryResponse> snapshot) {
                      if (snapshot.data is RecoveryResponseServerError) {
                        return Text(
                          snapshot.data.error,
                          style: kErrorTextStyle,
                        );
                      }
                      return Text(
                        "",
                        style: kErrorTextStyle,
                      );
                    }),
                GestureDetector(
                  onTap: bottomButtonTap,
                  child: Container(
                    height: 41,
                    width: 240,
                    decoration: kOrangeBoxDecorationOrangeBorder,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        _btnText,
                        style: kBottomTextStyleWhite,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

/*
  RecoveryResponseOk - ведет к скрину с вводом нового пароля
  RecoveryResponseServerError - 
  RecoveryResponseCodeError - 
  RecoveryResponseCodeChecking - скрин с индикатором загрузки
  RecoveryResponseCodeDidNotCome - 
  RecoveryResponseCodeSended - скрин с вводом кода
  RecoveryResponseToPhoneEnter - скрин с вводом телефона
*/

  void bottomButtonTap() {
    if (recoveryBloc.last is RecoveryResponseCodeSended) {
      if (!keys.formLoginKeys[9].currentState.validate()) {
        return;
      }
      recoveryBloc.codeCheck(_phoneNumber, _controller.text);
      _controller.clear();
    } else if (recoveryBloc.last is RecoveryResponseToPhoneEnter) {
      _phoneNumber = _controller.text;
      recoveryBloc.sendCode(_controller.text);
      _controller.clear();
    } else if (recoveryBloc.last is RecoveryResponseOk) {
      if (keys.formLoginKeys[1].currentState.validate()) {
        String newPass = _firstPassController.text;
        recoveryBloc.changePass(_phoneNumber, newPass);
      }
      _controller.clear();
    }
  }
}
