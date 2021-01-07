//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tigra/blocs/navigation_bloc.dart';
import 'package:tigra/blocs/user_auth_bloc.dart';
import 'package:tigra/elements/loading_spinkit.dart';
import 'package:tigra/main.dart';
import 'package:tigra/responses/user_response.dart';
import 'package:tigra/screens/authorisation_screen.dart';
import 'package:tigra/screens/home_screen.dart';
import 'package:tigra/widgets/widgets.dart';

class AuthCheckScreen extends StatefulWidget {
  @override
  _AuthCheckScreenState createState() => _AuthCheckScreenState();
}

class _AuthCheckScreenState extends State<AuthCheckScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserStates>(
      stream: authorisationBloc.subject.stream,
      initialData: UserStates.UNINITIALISED,
      builder: (context, AsyncSnapshot<UserStates> snapshot) {
        switch (snapshot.data) {
          case UserStates.AUTHORISED:
            return HomeSchreen();
            break;
          case UserStates.NONAUTHORISED:
            return AuthorisationScreen();
          case UserStates.UNINITIALISED:
            return PreAuthScreen();
          default:
            return PreAuthScreen();
        }
        /*if (snapshot.hasData) {
          //if (snapshot.data.user != null) return HomeSchreen();
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return PreAuthScreen();
          }
          return HomeSchreen();
        } else if (snapshot.hasError) {
          //yield
          return AuthorisationScreen();
        } else {
          return LoaderSpinkit();
        }*/
      },
    );
  }
}

class PreAuthScreen extends StatelessWidget {
  const PreAuthScreen({
    Key key,
  }) : super(key: key);

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
                      authorisationBloc..pickState(UserStates.NONAUTHORISED),
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
