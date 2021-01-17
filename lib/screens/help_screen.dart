import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tigra/main.dart';
import 'package:tigra/responses/user_response.dart';
import 'package:tigra/screens/recovery_screen.dart';
import 'package:tigra/styles/theme.dart';

class HelpScreen extends StatefulWidget {
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                child: Text(
                  "Помощь",
                  style: kTitleTextStyle,
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: size.width * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(helperText, style: kSurnameTextStyle),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Text(helperTextContacts,
                          style: kHelperContactsTextStyle),
                    )
                  ],
                ),
              ),
              GestureDetector(
                child: Text("Восстановить пароль",
                    style: kHelperContactsTextStyle),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RecoveryScreen()));
                },
              ),
              GestureDetector(
                onTap: () {
                  authorisationBloc.pickState(ToAuthScr());
                },
                child: Container(
                  height: 41,
                  width: 240,
                  decoration: kWhiteBoxDecorationBlackBorder.copyWith(
                      color: kBoxBlackColor),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Назад",
                      style: kBottomTextStyleWhite,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
