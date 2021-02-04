import 'package:flutter/material.dart';
import 'package:Tigra/elements/methods.dart';
import 'package:Tigra/main.dart';
import 'package:Tigra/models/log_and_pas.dart';
import 'package:Tigra/responses/user_response.dart';
import 'package:Tigra/styles/theme.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AuthorisationScreen extends StatefulWidget {
  @override
  _AuthorisationScreenState createState() => _AuthorisationScreenState();
}

class _AuthorisationScreenState extends State<AuthorisationScreen> {
  //final passKey = GlobalKey<FormState>();
  LoginAndPass userLP = LoginAndPass();
  var maskFormatter = new MaskTextInputFormatter(
      mask: '+7 (###) ###-##-##', filter: {"#": RegExp(r'[0-9]')});

  TextEditingController _loginController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //_loginController.value = TextEditingValue(text: "+79033064659");
    //_passwordController.value = TextEditingValue(text: "Google5656");
    double _statusBar = MediaQuery.of(context).padding.top;
    Size _size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: WillPopScope(
          onWillPop: () => authorisationBloc.pickState(UserUnAuth()),
          child: SingleChildScrollView(
            child: Container(
              height: _size.height - _statusBar,
              width: _size.width,
              color: kBackGroundColor,
              padding: EdgeInsets.fromLTRB(30, 90, 30, 60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Вход",
                    style: kTitleTextStyle,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Form(
                        key: AppKeys.keys0,
                        child: Container(
                          height: 41,
                          width: 240,
                          child: TextFormField(
                            //initialValue: "+79033064659",
                            controller: _loginController,
                            validator: (str) {
                              if (str.length < 18) {
                                return "Номер телефона слишком короткий";
                              } else if (str[1] != '7') {
                                return "Введите номер с кодом +7";
                              } else {
                                return null;
                              }
                            },
                            textAlign: TextAlign.center,
                            textAlignVertical: TextAlignVertical.bottom,
                            inputFormatters: [maskFormatter],
                            decoration: inputDecor("Номер телефона"),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Form(
                        key: AppKeys.keys1,
                        child: Container(
                          height: 41,
                          width: 240,
                          child: TextFormField(
                            //initialValue: "Google5656",
                            controller: _passwordController,
                            validator: (str) {
                              if (str.length == 0) {
                                return "Пароль слишком короткий";
                              } else {
                                return null;
                              }
                            },
                            decoration: inputDecor("Пароль"),
                            obscureText: true,
                            obscuringCharacter: '*',
                            textAlign: TextAlign.center,
                            textAlignVertical: TextAlignVertical.bottom,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                          onTap: () {
                            authorisationBloc.pickState(UserToHelp());
                          },
                          child:
                              Text("Помощь", style: kHelpBottomTextStyleBlack)),
                    ],
                  ),
                  Container(
                    height: 41,
                    width: 300,
                    child: StreamBuilder(
                      stream: authorisationBloc.subject.stream,
                      builder: (ctx, AsyncSnapshot<UserResponse> snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data is UserAuthFailed) {
                            return Text("Номер телефона или пароль неверен",
                                style: kErrorTextStyle);
                          }
                        }
                        return Text("");
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: _submit,
                    child: Container(
                      height: 41,
                      width: 240,
                      decoration: kOrangeBoxDecorationOrangeBorder,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Войти",
                          style: kBottomTextStyleWhite,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _submit() {
    try {
      if (AppKeys.keys0.currentState.validate() &&
          AppKeys.keys1.currentState.validate()) {
        userLP.login = convertToSimplePhoneNumber(_loginController.text);
        userLP.password = _passwordController.text;
        authorisationBloc.logIn(userLP);
      }
    } catch (eror) {}
  }
}

InputDecoration inputDecor(String hintStr) {
  return InputDecoration(
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide(
        color: kBoxBlackColor,
        width: 1,
      ),
    ),
    fillColor: Color(0xFFE5E5E5),
    hintText: hintStr,
    hintStyle: TextStyle(
        fontFamily: "roboto",
        fontSize: 18,
        color: Color(0xFF171717).withOpacity(0.5),
        fontWeight: FontWeight.w400),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide(
        color: kBoxBlackColor,
        width: 3,
      ),
    ),
  );
}
