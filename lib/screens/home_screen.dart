//import 'dart:html';
import 'package:flutter/material.dart';
import 'package:tigra/blocs/navigation_bloc.dart';
import 'package:tigra/main.dart';
import 'package:tigra/styles/constants.dart';
import 'package:tigra/styles/theme.dart';
import 'package:tigra/widgets/widgets.dart';

class HomeSchreen extends StatefulWidget {
  @override
  _HomeSchreenState createState() => _HomeSchreenState();
}

class _HomeSchreenState extends State<HomeSchreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainAppBar(
          text: Text(
            "Иванов Иван",
            style: kSurnameTextStyle,
          ),
          button: TextButton(
            onPressed: () => authorisationBloc.logOut(),
            child: Text(
              "Выйти",
              style: kButtonTextStyle,
            ),
          ),
          height: 150,
        ),
        backgroundColor: themeLight.scaffoldBackgroundColor,
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text(
                          "Посещения",
                          style: themeLight.textTheme.headline5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Общее количество:\n23"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Бесплатное посещение через: 1"),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 45),
                    child: VisitsColumn(remainder: 5),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.all(30),
                child: MainButton(
                  funct: () =>
                      navigatorBloc.pickNavigator(NavigatorMenu.QrScreen),
                  child: Text(
                    "Новое посещение",
                    style: kButtonTextStyle,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
