import 'package:flutter/material.dart';

ThemeData themeLight = ThemeData(
  //primarySwatch: Colors.blue,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  disabledColor: Colors.amber,
  appBarTheme: AppBarTheme(color: Color(0xFF313131), shadowColor: Colors.white),
  //brightness: Brightness.light,
  //primarySwatch: Color(0xFF3985c0),
  primaryIconTheme: IconThemeData(
    color: Color(0xFF3985c0),
  ),
  primaryTextTheme: TextTheme(
    headline6: TextStyle(color: Color(0xFF3985c0)),
  ),
  accentColor: Color(0xFF3985c0),
  cardColor: Color(0xFFffffff),
  primaryColor: Color(0xFFffffff),
  scaffoldBackgroundColor: Color(0xFFFFFFFF),
  canvasColor: Color(0xFFffffff),
  buttonColor: Color(0xFF313131),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    unselectedItemColor: Color(0xFF77818d),
    selectedItemColor: Color(0xFF3985c0),
    backgroundColor: Color(0xFFedeef0),
  ),
  textTheme: TextTheme(
    subtitle1: TextStyle(
      color: Color(0xFF3985c0),
      fontSize: 12,
      fontFamily: 'OpenSans',
    ),
    headline1: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w400,
      fontSize: 18,
      fontFamily: 'OpenSans',
    ),
    headline2: TextStyle(
      fontSize: 16,
      fontFamily: 'OpenSans',
    ),
    headline3: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Color(0xFF3985c0),
    ),
    headline4: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Color(0xFF77818d),
    ),
    headline5: TextStyle(
      fontSize: 22,
      color: Color(0xFF313131),
      fontWeight: FontWeight.bold,
      fontFamily: 'OpenSans',
    ),
  ),
);
