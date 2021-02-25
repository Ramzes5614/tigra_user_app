import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Tigra/main.dart';
import 'package:Tigra/responses/user_response.dart';
import 'package:Tigra/screens/recovery_screen.dart';
import 'package:Tigra/styles/theme.dart';

class HelpScreen extends StatefulWidget {
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: WillPopScope(
        onWillPop: () => authorisationBloc.pickState(ToAuthScr()),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      child: Text("Восстановить пароль",
                          style: kHelperButtonTextStyle),
                      onTap: () {
                        /*Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RecoveryScreen()));*/
                        authorisationBloc.pickState(UserToPassRec());
                      },
                    ),
                    SizedBox(
                      height: 15,
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
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
