import 'dart:ffi';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:tigra/blocs/navigation_bloc.dart';
import 'package:tigra/main.dart';
import 'package:tigra/models/user_model.dart';
import 'package:tigra/responses/user_response.dart';
import 'package:tigra/screens/authorisation_screen.dart';
import 'package:tigra/screens/pre_auth_screen.dart';
import 'package:tigra/styles/theme.dart';
import 'package:tigra/widgets/widgets.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  UserModel user;

  var maskFormatter = new MaskTextInputFormatter(
      mask: '+# (###) ###-##-##', filter: {"#": RegExp(r'[0-9]')});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () => authorisationBloc.pickState(UserUnAuth()),
        child: SafeArea(
          child: Center(
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "Регистрация",
                      style: kTitleTextStyle,
                    ),
                  ),
                  Column(
                    children: [
                      Form(
                        key: keys.formLoginKeys[4],
                        child: Container(
                          height: 50,
                          width: 240,
                          padding: EdgeInsets.all(5),
                          child: TextFormField(
                            validator: (str) {
                              if (str.length == 0) {
                                return "Введите фамилию";
                              }
                              return null;
                            },
                            controller: _surnameController,
                            decoration: inputDecor("Фамилия"),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Form(
                        key: keys.formLoginKeys[5],
                        child: Container(
                          height: 50,
                          width: 240,
                          padding: EdgeInsets.all(5),
                          child: TextFormField(
                            validator: (str) {
                              if (str.length == 0) {
                                return "Введите имя";
                              }
                              return null;
                            },
                            controller: _nameController,
                            decoration: inputDecor("Имя"),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Form(
                        key: keys.formLoginKeys[6],
                        child: Container(
                          height: 50,
                          width: 240,
                          padding: EdgeInsets.all(5),
                          child: TextFormField(
                            validator: (str) {
                              if (str.length > 255) {
                                return "Введите отчество";
                              }
                              return null;
                            },
                            controller: _middleNameController,
                            decoration: inputDecor("Отчество"),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Form(
                        key: keys.formLoginKeys[7],
                        child: Container(
                          height: 50,
                          width: 240,
                          padding: EdgeInsets.all(5),
                          child: TextFormField(
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
                            controller: _phoneNumberController,
                            decoration: inputDecor("Номер телефона"),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Form(
                        key: keys.formLoginKeys[8],
                        child: Container(
                          height: 50,
                          width: 240,
                          padding: EdgeInsets.all(5),
                          child: TextFormField(
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
                            controller: _passController,
                            decoration: inputDecor("Пароль"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (!keys.formLoginKeys[4].currentState.validate() ||
                          !keys.formLoginKeys[5].currentState.validate() ||
                          !keys.formLoginKeys[6].currentState.validate() ||
                          !keys.formLoginKeys[7].currentState.validate() ||
                          !keys.formLoginKeys[8].currentState.validate()) {
                        return;
                      }
                      user = new UserModel(
                          _surnameController.text,
                          _nameController.text,
                          _middleNameController.text,
                          _phoneNumberController.text,
                          _passController.text);
                    },
                    child: Container(
                      height: 41,
                      width: 240,
                      decoration: kOrangeBoxDecorationOrangeBorder,
                      padding: EdgeInsets.all(5),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Регистрация",
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
}
