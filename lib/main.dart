import 'package:flutter/material.dart';
import 'package:tigra/screens/main_screen.dart';
import 'styles/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Тигра',
      theme: themeLight,
      home: MainScreen(),
    );
  }
}
