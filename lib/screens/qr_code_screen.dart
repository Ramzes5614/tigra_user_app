import 'dart:ui';

import 'package:Tigra/responses/user_response.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icomoon_icons/flutter_icomoon_icons.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:Tigra/elements/methods.dart';
import 'package:Tigra/main.dart';
import 'package:Tigra/models/user_model.dart';
import 'package:Tigra/styles/theme.dart';
import 'package:Tigra/widgets/widgets.dart';
import 'dart:math' as math;

class QrCodeScreen extends StatefulWidget {
  final UserModel user;
  QrCodeScreen({this.user});
  @override
  _QrCodeScreenState createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  GlobalKey globalKey = new GlobalKey();
  final TextEditingController _textController = TextEditingController();
  String _dataString = "There is some phone number";
  String _inputErrorText;
  @override
  Widget build(BuildContext context) {
    final bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewInsets.bottom;
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
                    return BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                      child: Container(
                        height: 165,
                        width: 230,
                        child: AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 20,
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Выйти из аккаунта",
                              style: kConfirmTextStyle,
                              textAlign: TextAlign.center,
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
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  height: 46,
                                  width: 90,
                                  decoration: kOrangeBoxDecorationOrangeBorder,
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Text("Нет",
                                          style: kConfirmButtonTextStyleWhite)),
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
                                  authorisationBloc.logOut();
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  height: 46,
                                  width: 90,
                                  decoration: kWhiteBoxDecorationBlackBorder,
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Text("Да",
                                          style: kConfirmButtonTextStyle)),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  })
            },
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
          height: 56,
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(30, 60, 30, 60),
          color: kBackGroundColor,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: AutoSizeText(
                    qrCodeText,
                    style: kHelperTextStyle,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.visible,
                  ),
                ),
                //GenerateScreen(_dataString)
                Container(
                  child: Center(
                    child: RepaintBoundary(
                      key: globalKey,
                      child: QrImage(
                        data: convertToSimplePhoneNumber(
                            widget.user.userPhoneNumber),
                        size: 0.30 * bodyHeight,
                        errorStateBuilder: (context, err) {
                          return Container(
                            padding: EdgeInsets.all(15),
                            child: Text("QR ERROR\nSOMETHING IS WRONG..."),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
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
              ]),
        ));
  }
}
