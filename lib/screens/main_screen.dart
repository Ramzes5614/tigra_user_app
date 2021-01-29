import 'package:flutter/material.dart';
import 'package:Tigra/elements/loading_spinkit.dart';
import 'package:Tigra/elements/transparent_loading.dart';
import 'package:Tigra/main.dart';
import 'package:Tigra/responses/user_response.dart';
import 'package:Tigra/screens/authorisation_screen.dart';
import 'package:Tigra/screens/help_screen.dart';
import 'package:Tigra/screens/home_screen.dart';
import 'package:Tigra/screens/logo_screen.dart';
import 'package:Tigra/screens/qr_code_screen.dart';
import 'package:Tigra/screens/registration_screen.dart';

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
    return StreamBuilder<UserResponse>(
      //stream: navigatorBloc.itemStream,
      stream: authorisationBloc.subject.stream,
      //initialData: authorisationBloc.defaultItem,
      builder: (context, AsyncSnapshot<UserResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data is UserLoggedIn) {
            return HomeSchreen(user: snapshot.data.user);
          } else if (snapshot.data is ToAuthScr) {
            return AuthorisationScreen();
          } else if (snapshot.data is ToRegScr) {
            return RegistrationScreen();
          } else if (snapshot.data is UserLoading) {
            return TransparentLoader();
          } else if (snapshot.data is UserUnAuth) {
            return LogoScreen();
          } else if (snapshot.data is UserAuthFailed) {
            return AuthorisationScreen();
          } else if (snapshot.data is UserToQrScreen) {
            return QrCodeScreen();
          } else if (snapshot.data is UserToHelp) {
            return HelpScreen();
          } else {
            return LogoScreen();
          }
        } else {
          //authorisationBloc.logInWithLocal();
          return LoaderSpinkit();
        }
      },
    );
  }
}
