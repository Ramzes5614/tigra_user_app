import 'package:flutter/material.dart';
import 'package:tigra/blocs/navigation_bloc.dart';
import 'package:tigra/blocs/user_auth_bloc.dart';
import 'package:tigra/elements/loading_spinkit.dart';
import 'package:tigra/elements/transparent_loading.dart';
import 'package:tigra/main.dart';
import 'package:tigra/responses/user_response.dart';
import 'package:tigra/screens/authorisation_screen.dart';
import 'package:tigra/screens/home_screen.dart';
import 'package:tigra/screens/pre_auth_screen.dart';
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
          } else {
            return PreAuthScreen();
          }
        } else {
          authorisationBloc.logInWithLocal();
          return LoaderSpinkit();
        }

        /*switch (snapshot.data) {
          case UserStates.AUTHORISED:
            return HomeSchreen();
            break;
          case UserStates.NONAUTHORISED:
            return PreAuthScreen();
            break;
          case UserStates.UNINITIALISED:
            authorisationBloc.logInWithLocal();
            return LoaderSpinkit();
            //return RegistrationScreen();
            break;
          case UserStates.AUTHORISATIONSCREEN:
            return AuthorisationScreen();
            break;
          default:
            return Scaffold();
            break;
        }*/
      },
    );
  }
}
