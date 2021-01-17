import 'package:flutter/material.dart';
import 'package:tigra/main.dart';
import 'package:tigra/responses/user_response.dart';
import 'package:tigra/styles/theme.dart';

class RecoveryScreen extends StatefulWidget {
  @override
  _RecoveryScreen createState() => _RecoveryScreen();
}

class _RecoveryScreen extends State<RecoveryScreen> {
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
                  "Восстановить пароль",
                  style: kTitleTextStyle,
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: size.width * 0.7,
                child: null,
              ),
              GestureDetector(
                child: Text("Восстановить пароль",
                    style: kHelperContactsTextStyle),
                onTap: () {},
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
