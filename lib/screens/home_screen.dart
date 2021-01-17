//import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:tigra/models/user_model.dart';
import 'package:tigra/main.dart';
import 'package:tigra/responses/user_response.dart';
import 'package:tigra/screens/qr_code_screen.dart';
import 'package:tigra/styles/theme.dart';
import 'package:tigra/widgets/widgets.dart';

class HomeSchreen extends StatefulWidget {
  final UserModel user;
  HomeSchreen({this.user});
  @override
  _HomeSchreenState createState() => _HomeSchreenState();
}

class _HomeSchreenState extends State<HomeSchreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainAppBar(
          text: Text(
            "${widget.user.name}",
            style: kSurnameTextStyleWhite,
          ),
          button: TextButton(
            onPressed: () => {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Container(
                      height: 165,
                      width: 240,
                      child: AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 20,
                        content: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Выйти из аккаунта",
                            style: kNameTextStyle,
                          ),
                        ),
                        //actionsOverflowButtonSpacing: 40,
                        actionsPadding: EdgeInsets.all(20),
                        actions: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                height: 46,
                                width: 90,
                                decoration: kOrangeBoxDecorationOrangeBorder,
                                child: Align(
                                    alignment: Alignment.center,
                                    child:
                                        Text("Нет", style: kConfirmTextStyle)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                authorisationBloc.logOut();
                              },
                              child: Container(
                                height: 46,
                                width: 90,
                                decoration: kWhiteBoxDecorationBlackBorder,
                                child: Align(
                                    alignment: Alignment.center,
                                    child:
                                        Text("Да", style: kConfirmTextStyle)),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  })
            },
            //authorisationBloc.updateUserState(widget.user.userPhoneNumber);
            //} /*() => authorisationBloc..logOut()*/,
            child: Container(
              height: 36,
              width: 36,
              decoration: kAppBarBottomBoxDecoration,
              child: Icon(
                Icons.arrow_back,
                color: kBoxBlackColor,
                size: 18.5,
              ),
            ),
          ),
          height: 150,
        ),
        backgroundColor: themeLight.scaffoldBackgroundColor,
        body: Padding(
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${widget.user.name}",
                              style: kNameTextStyle,
                            ),
                            SizedBox(
                              height: 1,
                            ),
                            Text(
                              "${widget.user.surname}",
                              style: kSurnameTextStyle,
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 24),
                              child: Text(
                                "${widget.user.userPhoneNumber}",
                                style: kSurnameTextStyle,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  Text("До бесплатного посещения:", style: kSurnameTextStyle),
                  Text(
                    "${5 - (widget.user.visits % 5) - 1}",
                    style: kVisitsNumberTextStyle,
                  )
                ],
              ),
              CircleVisits(widget.user.visits),
              Padding(
                padding: EdgeInsets.all(30),
                child: Column(children: [
                  Container(
                      height: 41,
                      width: 300,
                      child: widget.user.visits % 5 == 4
                          ? Text(
                              "Бесплатное посещение!",
                              style: kVisitsTextStyle,
                            )
                          : Text("")),
                  GestureDetector(
                    onTap: () =>
                        /*{
                      authorisationBloc.pickState(UserToQrScreen(widget.user))
                    },*/
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (context) => QrCodeScreen(
                                  user: widget.user,
                                ))),
                    /*navigatorBloc.pickNavigator(NavigatorMenu.QrScreen)*/
                    child: Container(
                      //padding: EdgeInsets.all(50),
                      height: 41,
                      width: 240,
                      decoration: kOrangeBoxDecorationOrangeBorder,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Новое посещение",
                          style: kBottomTextStyleWhite,
                        ),
                      ),
                    ),
                  ),
                ]),
              )
            ],
          ),
        ));
  }
}
