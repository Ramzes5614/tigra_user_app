//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:tigra/blocs/navigation_bloc.dart';
import 'package:tigra/main.dart';
import 'package:tigra/widgets/widgets.dart';

class PreAuthScreen extends StatefulWidget {
  @override
  _PreAuthScreenState createState() => _PreAuthScreenState();
}

class _PreAuthScreenState extends State<PreAuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.fromLTRB(25, 250, 25, 50),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child: MainButton(
                  child: Text(
                    "Войти",
                    style: TextStyle(color: Colors.white),
                  ),
                  funct: () =>
                      navigatorBloc.pickNavigator(NavigatorMenu.Authorisation),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: MainButton(
                  child: Text(
                    "Регистрация",
                    style: TextStyle(color: Colors.white),
                  ),
                  funct: () =>
                      navigatorBloc.pickNavigator(NavigatorMenu.Registration),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: MainButton(
                  child: Text(
                    "Помощь",
                    style: TextStyle(color: Colors.white),
                  ),
                  funct: () =>
                      navigatorBloc.pickNavigator(NavigatorMenu.Authorisation),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
