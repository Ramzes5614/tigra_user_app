import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tigra/blocs/navigation_bloc.dart';
import 'package:tigra/main.dart';
import 'package:tigra/responses/user_response.dart';
import 'package:tigra/screens/pre_auth_screen.dart';
import 'package:tigra/styles/constants.dart';
import 'package:tigra/styles/theme.dart';
import 'package:tigra/widgets/widgets.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => authorisationBloc.pickState(UserUnAuth()),
      /*navigatorBloc.pickNavigator(NavigatorMenu.AuthCheck),*/
      child: Scaffold(
        appBar: MainAppBar(
          height: 150,
          text: Text(
            "Регистрация",
            style: themeLight.textTheme.headline6,
          ),
          button: TextButton(
            onPressed: () => authorisationBloc.pickState(UserUnAuth()),
            child: Text(
              "Назад",
              style: kButtonTextStyle,
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(25),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "Регистрация",
                      style: themeLight.textTheme.headline6,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: CostomTextField(_surnameController, "Фамилия"),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: CostomTextField(_nameController, "Имя"),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: CostomTextField(
                        _phoneNumberController, "Номер телефона"),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: CostomTextField(_codeController, "Код"),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: MainButton(
                      child: Text("Регистрация"),
                      funct: () {},
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
