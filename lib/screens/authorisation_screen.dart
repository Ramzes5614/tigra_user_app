import 'package:flutter/material.dart';
import 'package:tigra/elements/methods.dart';
import 'package:tigra/main.dart';
import 'package:tigra/models/log_and_pas.dart';
import 'package:tigra/responses/user_response.dart';
import 'package:tigra/styles/theme.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AuthorisationScreen extends StatefulWidget {
  @override
  _AuthorisationScreenState createState() => _AuthorisationScreenState();
}

class _AuthorisationScreenState extends State<AuthorisationScreen> {
  final formKey = GlobalKey<FormState>();
  //final passKey = GlobalKey<FormState>();
  LoginAndPass userLP = LoginAndPass();
  var maskFormatter = new MaskTextInputFormatter(
      mask: '+# (###) ###-##-##', filter: {"#": RegExp(r'[0-9]')});

  TextEditingController _loginController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _loginController.value = TextEditingValue(text: "+79033064659");
    _passwordController.value = TextEditingValue(text: "Google5656");
    return Scaffold(
      body: WillPopScope(
        onWillPop: () => authorisationBloc.pickState(UserUnAuth()),
        child: SafeArea(
          child: Center(
            child: Container(
              padding: EdgeInsets.fromLTRB(25, 150, 25, 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Вход",
                    style: kTitleTextStyle,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Container(
                          height: 41,
                          width: 240,
                          child: TextFormField(
                            //initialValue: "+79033064659",
                            controller: _loginController,
                            validator: (str) {
                              if (str.length == 0) {
                                return "Введите номер телефона";
                              } else if (str[1] != '7') {
                                return "Введите номер с кодом +7";
                              } else {
                                return null;
                              }
                            },
                            inputFormatters: [maskFormatter],
                            decoration: inputDecor("Номер телефона"),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 41,
                          width: 240,
                          child: TextFormField(
                            //initialValue: "Google5656",
                            controller: _passwordController,
                            validator: (str) {
                              if (str.length < 6) {
                                return "Пароль слишком короткий";
                              } else if (!str.contains(new RegExp(r'[0-9]'))) {
                                return "Пороль должен содержать хотя-бы одну цифру";
                              } else if (!str.contains(new RegExp(r'[a-x]'))) {
                                return "Пароль должен содержать хотя-бы одну букву латинского алфавита";
                              } else if (str.length > 32) {
                                return "Пароль слишком длинный";
                              } else {
                                return null;
                              }
                            },
                            decoration: inputDecor("Пароль"),
                            obscureText: true,
                            obscuringCharacter: '*',
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                            onTap: () {
                              authorisationBloc.pickState(UserToHelp());
                            },
                            child: Text("Помощь",
                                style: kHelpBottomTextStyleBlack)),
                      ],
                    ),
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
    if (formKey.currentState.validate()) {
      userLP.login = convertToSimplePhoneNumber(_loginController.text);
      userLP.password = _passwordController.text;
      authorisationBloc.logIn(userLP);
    }
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
        fontWeight: FontWeight.normal),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide(
        color: kBoxBlackColor,
        width: 3,
      ),
    ),
  );
}
