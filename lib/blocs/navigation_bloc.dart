import 'dart:async';

enum NavigatorMenu { LOGO, AUTHORISATION, REGISTRATION, HOME, QRSCREEN }

class NavigationBloc {
  final StreamController<NavigatorMenu> _streamController =
      StreamController<NavigatorMenu>.broadcast();
  NavigatorMenu defaultItem = NavigatorMenu.LOGO;

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
