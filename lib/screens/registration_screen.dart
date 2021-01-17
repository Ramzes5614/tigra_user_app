import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:tigra/blocs/navigation_bloc.dart';
import 'package:tigra/main.dart';
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
                      Container(
                        height: 50,
                        width: 240,
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          controller: _surnameController,
                          decoration: inputDecor("Фамилия"),
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 240,
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          controller: _nameController,
                          decoration: inputDecor("Имя"),
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 240,
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          controller: _middleNameController,
                          decoration: inputDecor("Отчество"),
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 240,
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          inputFormatters: [maskFormatter],
                          controller: _phoneNumberController,
                          decoration: inputDecor("Номер телефона"),
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 240,
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          controller: _passController,
                          decoration: inputDecor("Пароль"),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
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
