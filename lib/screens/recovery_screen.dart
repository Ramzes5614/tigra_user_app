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
  RecoveryBloc recoveryBloc = RecoveryBloc();
  String _btnText = "Далее";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
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
                      if (snapshot.data is RecoveryResponseCodeSended) {
                        return CodeEnterWidget(_controller);
                      } else if (snapshot.data
                          is RecoveryResponseCodeChecking) {
                        return loadingSpinkit();
                      } else if (snapshot.data is RecoveryResponseCodeError) {
                      } else if (snapshot.data is RecoveryResponseOk) {
                        return PassChangeContainer();
                      }
                    }
                    return PhoneEnterContainer(_controller);
                  },
                ),
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
      recoveryBloc.codeCheck(_controller.text);
    } else if (recoveryBloc.last is RecoveryResponseCodeError) {
      recoveryBloc.codeCheck(_controller.text);
    } else if (recoveryBloc.last is RecoveryResponseOk) {
    } else if (recoveryBloc.last is RecoveryResponseToPhoneEnter) {
      recoveryBloc.sendCode(_controller.text);
    }
  }
}
