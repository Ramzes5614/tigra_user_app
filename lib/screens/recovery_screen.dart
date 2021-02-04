import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:Tigra/blocs/recovary_bloc.dart';
import 'package:Tigra/elements/loading_spinkit.dart';
import 'package:Tigra/responses/recovery_response.dart';
import 'package:Tigra/styles/theme.dart';
import 'package:Tigra/widgets/pass_changing.dart';
import 'package:Tigra/widgets/recovery_code_enter_widget.dart';
import 'package:Tigra/widgets/recovery_phone_enter_widget.dart';

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
    Size _size = MediaQuery.of(context).size;
    double _statusBar = MediaQuery.of(context).padding.top;
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
          body: SingleChildScrollView(
            child: Container(
              width: _size.width,
              height: _size.height - _statusBar,
              //alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: AutoSizeText(
                        "Восстановить пароль",
                        style: kTitleTextStyle,
                      ),
                    ),
                  ),
                  StreamBuilder(
                    initialData: recoveryBloc.defaultItem,
                    stream: recoveryBloc.subject.stream,
                    builder:
                        (context, AsyncSnapshot<RecoveryResponse> snapshot) {
                      if (snapshot.hasData) {
                        ///to phone enter screen
                        if (snapshot.data is RecoveryResponseToPhoneEnter) {
                          return PhoneEnterContainer(_controller);

                          ///code sended
                        } else if (snapshot.data
                            is RecoveryResponseCodeSended) {
                          return CodeEnterWidget(
                              codeController: _controller,
                              onTapF: () => recoveryBloc.didNotCame());
                        }

                        ///checking the code
                        else if (snapshot.data
                            is RecoveryResponseCodeChecking) {
                          return loadingSpinkit();
                        }

                        ///code checked
                        else if (snapshot.data is RecoveryResponseOk) {
                          return PassChangeContainer(
                              _firstPassController, _secondPassController);
                        } else if (snapshot.data
                            is RecoveryResponsePassChanged) {
                          Navigator.pop(context);
                        } else if (snapshot.data is RecoveryResponseCodeError) {
                          return CodeEnterWidget(
                              codeController: _controller,
                              onTapF: () => recoveryBloc.didNotCame());
                        }
                        /*else if (snapshot.data
                            is RecoveryResponseCodeDidNotCome) {
                          //return PhoneEnterContainer(_controller);
                          return CodeEnterWidget(codeController: _controller);
                        }*/
                      }
                      return PhoneEnterContainer(_controller);
                    },
                  ),
                  StreamBuilder<RecoveryResponse>(
                      stream: recoveryBloc.subject.stream,
                      builder:
                          (context, AsyncSnapshot<RecoveryResponse> snapshot) {
                        if (snapshot.data is RecoveryResponseCodeError) {
                          return AutoSizeText(
                            snapshot.data.error,
                            style: kErrorTextStyle,
                            overflow: TextOverflow.visible,
                          );
                        } else if (snapshot.data
                            is RecoveryResponseServerError) {
                          return AutoSizeText(
                            snapshot.data.error,
                            style: kErrorTextStyle,
                            overflow: TextOverflow.visible,
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
    if (recoveryBloc.last is RecoveryResponseCodeSended ||
        recoveryBloc.last is RecoveryResponseCodeError) {
      if (!AppKeys.keys10.currentState.validate()) {
        return;
      }
      recoveryBloc.codeCheck(_phoneNumber, _controller.text);
      _controller.clear();
    } else if (recoveryBloc.last is RecoveryResponseToPhoneEnter) {
      if (!AppKeys.keys12.currentState.validate()) {
        return;
      }
      _phoneNumber = _controller.text;
      recoveryBloc.sendCode(_controller.text);
      _controller.clear();
    } else if (recoveryBloc.last is RecoveryResponseOk) {
      if (AppKeys.keys2.currentState.validate() &&
          AppKeys.keys3.currentState.validate()) {
        String newPass = _firstPassController.text;
        recoveryBloc.changePass(_phoneNumber, newPass);
      }
      _controller.clear();
    }
  }
}
