import 'package:flutter/material.dart';
import 'package:tigra/elements/loading_spinkit.dart';
import 'package:tigra/elements/transparent_loading.dart';
import 'package:tigra/main.dart';
import 'package:tigra/responses/user_response.dart';
import 'package:tigra/screens/authorisation_screen.dart';
import 'package:tigra/screens/help_screen.dart';
import 'package:tigra/screens/home_screen.dart';
import 'package:tigra/screens/logo_screen.dart';
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
          authorisationBloc.logInWithLocal();
          return LoaderSpinkit();
        }
      },
    );
  }
}
