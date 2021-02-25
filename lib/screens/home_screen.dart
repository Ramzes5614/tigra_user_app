import 'package:Tigra/main.dart';
import 'package:Tigra/responses/user_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:Tigra/elements/methods.dart';
import 'package:Tigra/models/user_model.dart';
import 'package:Tigra/screens/qr_code_screen.dart';
import 'package:Tigra/styles/theme.dart';
import 'package:Tigra/widgets/widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_icomoon_icons/flutter_icomoon_icons.dart';
import 'dart:math' as math;

class HomeSchreen extends StatefulWidget {
  final UserModel user;
  HomeSchreen({this.user});
  @override
  _HomeSchreenState createState() => _HomeSchreenState();
}

class _HomeSchreenState extends State<HomeSchreen> {
  int _visitsToFree = 0;
  @override
  Widget build(BuildContext context) {
    if (widget.user.visits == null) {
      _visitsToFree = 5;
    } else {
      _visitsToFree = 5 - (widget.user.visits % 5);
    }
    Size _size = MediaQuery.of(context).size;
    //double _statusBar = MediaQuery.of(context).padding.top;
    return SafeArea(
      child: WillPopScope(
        onWillPop: () => showCustDialog(context),
        child: Scaffold(
            appBar: MainAppBar(
              text: Text(
                "${widget.user.name}",
                style: kSurnameTextStyleWhite,
              ),
              button: TextButton(
                onPressed: () => {showCustDialog(context)},
                //authorisationBloc.updateUserState(widget.user.userPhoneNumber);
                //} /*() => authorisationBloc..logOut()*/,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    height: 36,
                    width: 36,
                    decoration: kAppBarBottomBoxDecoration,
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(math.pi),
                      child: Icon(
                        IcoMoonIcons.exit,
                        color: kBoxBlackColor,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ),
              height: 56,
            ),
            backgroundColor: kBackGroundColor,
            body: SingleChildScrollView(
              //padding: EdgeInsets.fromLTRB(30, 60, 30, 50),
              child: Container(
                height: _size.height * 0.89,
                width: _size.width,
                padding: EdgeInsets.fromLTRB(30, 60, 30, 50),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      //crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ConstrainedBox(
                          constraints:
                              BoxConstraints(maxHeight: 130, minHeight: 100),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                "${widget.user.name}",
                                style: kNameTextStyle,
                              ),
                              AutoSizeText(
                                "${widget.user.surname}",
                                style: kSurnameTextStyle,
                              ),
                              AutoSizeText(
                                "${widget.user.middlename}",
                                style: kKidNameTextStyle,
                              ),
                              Spacer(),
                              AutoSizeText(
                                "${convertFromSimplePhoneNumber(widget.user.userPhoneNumber)}",
                                style: kSurnameTextStyle,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          child: Flexible(
                            child: AutoSizeText("До бесплатного\nосталось:",
                                overflow: TextOverflow.visible,
                                style: kPreVisitsTextStyle),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            authorisationBloc.updateUserState(widget.user);
                          },
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AutoSizeText(
                                  "$_visitsToFree",
                                  style: kVisitsNumberTextStyle,
                                  maxFontSize: 144,
                                ),
                                AutoSizeText(
                                  getVisitsCountString(_visitsToFree),
                                  style: kAfterNumTextStyle,
                                ),
                                AutoSizeText(
                                  "(Нажмите, чтобы обновить)",
                                  style: kAfterNumTextStyle,
                                  maxFontSize: 10,
                                  minFontSize: 8,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    CircleVisits(widget.user.visits),
                    Spacer(
                      flex: 1,
                    ),
                    Column(
                      //mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                            alignment: Alignment.center,
                            height: 41,
                            width: 300,
                            child: _visitsToFree == 1
                                ? AutoSizeText(
                                    "Бесплатное посещение!",
                                    style: kVisitsTextStyle,
                                  )
                                : Text("")),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () =>
                              Navigator.of(context).push(new MaterialPageRoute(
                                  builder: (context) => QrCodeScreen(
                                        user: widget.user,
                                      ))),
                          child: Container(
                            height: 41,
                            width: 240,
                            decoration: kOrangeBoxDecorationOrangeBorder,
                            child: Align(
                              alignment: Alignment.center,
                              child: AutoSizeText(
                                "Новое посещение",
                                style: kBottomTextStyleWhite,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  String getVisitsCountString(int n) {
    String retStr;
    switch (n) {
      case 0:
        retStr = "посещений";
        break;
      case 1:
        retStr = "посещение";
        break;
      case 2:
        retStr = "посещения";
        break;
      case 3:
        retStr = "посещения";
        break;
      case 4:
        retStr = "посещения";
        break;
      case 5:
        retStr = "посещений";
        break;
      default:
        retStr = "Посещений";
        break;
    }
    return retStr;
  }
}
