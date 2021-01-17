import 'package:flutter/material.dart';
import 'package:tigra/main.dart';
import 'package:tigra/responses/user_response.dart';
import 'package:tigra/styles/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogoScreen extends StatefulWidget {
  @override
  _LogoScreenState createState() => _LogoScreenState();
}

class _LogoScreenState extends State<LogoScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 170, width: 250, child: SvgPicture.asset(assetName)),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                authorisationBloc.pickState(ToRegScr());
              },
              child: Container(
                //padding: EdgeInsets.all(10),
                width: 240,
                height: 41,
                //color: kBottomColorOrange,
                decoration: kOrangeBoxDecorationOrangeBorder,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Регистрация",
                    style: kBottomTextStyleWhite,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                authorisationBloc.pickState(ToAuthScr());
              },
              child: Container(
                //padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                width: 240,
                height: 41,
                //color: kBottomColorWhite,
                decoration: kWhiteBoxDecorationOrangeBorder,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Вход",
                    style: kBottomTextStyleOrange,
                  ),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
