import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:Tigra/screens/authorisation_screen.dart';
import 'package:Tigra/styles/theme.dart';
import 'package:Tigra/widgets/timer_widget.dart';

class CodeEnterWidget extends StatefulWidget {
  final TextEditingController codeController;
  final Function onTapF;
  CodeEnterWidget({this.codeController, this.onTapF});
  @override
  _CodeEnterWidgetState createState() => _CodeEnterWidgetState();
}

class _CodeEnterWidgetState extends State<CodeEnterWidget> {
  //TextEditingController _loginController = TextEditingController();
  Widget _timer = SizedBox();
  int _duration = 60;
  bool _timerWorking = false;
  var maskFormatter = new MaskTextInputFormatter(
      mask: '######', filter: {"#": RegExp(r'[0-9]')});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Подтвердите ваш номер телефона",
            style: kSurnameTextStyle,
          ),
          SizedBox(
            height: 15,
          ),
          Text("Мы отправили смс с кодом на ваш номер",
              style: kSurnameTextStyle.copyWith(
                  color: Color(0xFF313131).withOpacity(0.5))),
          SizedBox(
            height: 15,
          ),
          Form(
            key: AppKeys.keys10,
            child: Container(
              width: 240,
              height: 41,
              child: TextFormField(
                //initialValue: "+79033064659",
                controller: widget.codeController,
                validator: (str) {
                  if (str.length == 0) {
                    return "Введите код";
                  } else if (str.length < 6) {
                    return "Код слишком короткий";
                  } else {
                    return null;
                  }
                },
                inputFormatters: [maskFormatter],
                decoration: inputDecor("Код"),
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.bottom,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () {
              widget.onTapF();
              if (!_timerWorking) {
                setState(() {
                  _timerWorking = true;
                  _timer = Column(
                    children: [
                      Text(
                        "До повторной отправки:",
                        style: kDoubleSendTextStyle,
                      ),
                      CountDownTimer(
                        secondsRemaining: _duration,
                        countDownTimerStyle:
                            TextStyle(color: kOrangeCircleColor, fontSize: 15),
                        whenTimeExpires: () {
                          setState(() {
                            _timerWorking = false;
                            _timer = SizedBox();
                            if (_duration == 300) {
                              _duration = 900;
                            } else if (_duration == 60) {
                              _duration = 300;
                            }
                          });
                        },
                      ),
                    ],
                  );
                });
              }
            },
            child: Text("не пришел код?", style: kHelperContactsTextStyle),
          ),
          SizedBox(
            height: 10,
          ),
          _timer,
        ],
      ),
    );
  }
}
