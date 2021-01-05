import 'dart:async';

import 'package:flutter/material.dart';

enum NavigatorMenu {
  AuthCheck,
  Authorisation,
  Registration,
  HomePage,
  QrScreen
}

class NavigationBloc {
  final StreamController<NavigatorMenu> _streamController =
      StreamController<NavigatorMenu>.broadcast();
  NavigatorMenu defaultItem = NavigatorMenu.AuthCheck;

  Stream<NavigatorMenu> get itemStream => _streamController.stream;

  pickNavigator(NavigatorMenu nav) {
    /*switch (nav) {
      case NavigatorMenu.Main:
        break;
      case NavigatorMenu.Authorisation:
        break;
      case NavigatorMenu.Registration:
        break;
      case NavigatorMenu.HomePage:
        break;
      case NavigatorMenu.QrScreen:
        break;
    }*/
    _streamController.sink.add(nav);
  }

  close() {
    _streamController?.close();
  }
}
