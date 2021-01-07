import 'package:flutter/material.dart';
import 'package:tigra/blocs/navigation_bloc.dart';
import 'package:tigra/main.dart';
import 'package:tigra/styles/theme.dart';
import 'package:tigra/widgets/widgets.dart';

class AuthorisationScreen extends StatefulWidget {
  @override
  _AuthorisationScreenState createState() => _AuthorisationScreenState();
}

class _AuthorisationScreenState extends State<AuthorisationScreen> {
  TextEditingController _loginController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            padding: EdgeInsets.fromLTRB(25, 150, 25, 50),
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    "Вход",
                    style: themeLight.textTheme.headline6,
                  ),
                ),
                Expanded(
                    flex: 1, child: CostomTextField(_loginController, "Логин")),
                Expanded(
                  flex: 1,
                  child: CostomTextField(_passwordController, "Пороль"),
                ),
                Expanded(
                  flex: 1,
                  child: MainButton(
                    child: Text(
                      "Войти",
                      style: themeLight.textTheme.headline2,
                    ),
                    funct: () => authorisationBloc
                      ..logIn(_loginController.text, _passwordController.text),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
