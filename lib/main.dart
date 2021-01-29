import 'package:flutter/material.dart';
import 'package:tigra/blocs/user_auth_bloc.dart';
import 'package:tigra/screens/main_screen.dart';
import 'styles/theme.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

//final navigatorBloc = NavigationBloc();
final authorisationBloc = UserAuthorisationBloc();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(title: 'Тигра', theme: themeLight, home: MainScreen());
  }
}
