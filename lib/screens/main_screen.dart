import 'package:flutter/material.dart';
import 'package:tigra/blocs/navigation_bloc.dart';
import 'package:tigra/main.dart';
import 'package:tigra/screens/authorisation_screen.dart';
import 'package:tigra/screens/home_screen.dart';
import 'package:tigra/screens/pre_auth_screen.dart';
import 'package:tigra/screens/qr_code_screen.dart';
import 'package:tigra/screens/registration_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    authorisationBloc.logInWithLocal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: navigatorBloc.itemStream,
      initialData: navigatorBloc.defaultItem,
      builder: (context, AsyncSnapshot<NavigatorMenu> snapshot) {
        switch (snapshot.data) {
          case NavigatorMenu.AuthCheck:
            return AuthCheckScreen();
            break;
          case NavigatorMenu.Authorisation:
            return AuthorisationScreen();
            break;
          case NavigatorMenu.Registration:
            return RegistrationScreen();
            break;
          case NavigatorMenu.HomePage:
            return HomeSchreen();
            break;
          case NavigatorMenu.QrScreen:
            return QrCodeScreen();
            break;
          default:
            return Scaffold();
            break;
        }
      },
    );
  }
}
