import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tigra/main.dart';
import 'package:tigra/models/user_model.dart';
import 'package:tigra/styles/theme.dart';
import 'package:tigra/widgets/widgets.dart';

class QrCodeScreen extends StatefulWidget {
  final UserModel user;
  QrCodeScreen({this.user});
  @override
  _QrCodeScreenState createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  static const double _topSectionTopPadding = 50.0;
  static const double _topSectionBottomPadding = 20.0;
  static const double _topSectionHeight = 50.0;
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
          height: 140,
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.only(
              top: _topSectionTopPadding,
              left: 20.0,
              right: 10.0,
              bottom: _topSectionBottomPadding,
            ),
            child: Container(
              height: _topSectionHeight,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  /*Expanded(
                      child: Text(widget.user.userPhoneNumber,
                          style: themeLight.textTheme.headline5),
                    )*/
                  /*Expanded(
                      child: TextField(
                        controller: _textController,
                        decoration: InputDecoration(
                          hintText: "Enter a custom message",
                          errorText: _inputErrorText,
                        ),
                      ),
                    ),*/
                  /*Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: FlatButton(
                        child: Text("Сгенерировать"),
                        onPressed: () {
                          setState(() {
                            _dataString = _textController.text;
                            _inputErrorText = null;
                          });
                        },
                      ),
                    )*/
                ],
              ),
            ),
          ),
          //GenerateScreen(_dataString)
          Container(
            child: Center(
              child: RepaintBoundary(
                key: globalKey,
                child: QrImage(
                  data: widget.user.userPhoneNumber,
                  size: 0.5 * bodyHeight,
                  errorStateBuilder: (context, err) {
                    return Container(
                      padding: EdgeInsets.all(15),
                      child: Text("QR ERROR\nSOMETHING IS WRONG..."),
                    );
                  },
                ),
              ),
            ),
          )
        ]));
  }
}
