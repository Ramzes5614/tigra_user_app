import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tigra/blocs/navigation_bloc.dart';
import 'package:tigra/blocs/user_auth_bloc.dart';
import 'package:tigra/screens/authorisation_screen.dart';
import 'package:tigra/screens/home_screen.dart';
import 'package:tigra/screens/main_screen.dart';
import 'package:tigra/screens/qr_code_screen.dart';
import 'package:tigra/screens/registration_screen.dart';
import 'styles/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

//final navigatorBloc = NavigationBloc();
final authorisationBloc = UserAuthorisationBloc();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Тигра', theme: themeLight, home: MainScreen());
  }
}
