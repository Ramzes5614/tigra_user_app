import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tigra/blocs/navigation_bloc.dart';
import 'package:tigra/main.dart';
import 'package:tigra/styles/constants.dart';
import 'package:tigra/widgets/qr_code_widget.dart';
import 'package:tigra/widgets/widgets.dart';

class QrCodeScreen extends StatefulWidget {
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
            "Иванов Иван",
            style: kSurnameTextStyle,
          ),
          button: TextButton(
            onPressed: () =>
                navigatorBloc.pickNavigator(NavigatorMenu.HomePage),
            child: Text(
              "Назад",
              style: kButtonTextStyle,
            ),
          ),
          height: 140,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
                    Expanded(
                      child: TextField(
                        controller: _textController,
                        decoration: InputDecoration(
                          hintText: "Enter a custom message",
                          errorText: _inputErrorText,
                        ),
                      ),
                    ),
                    Padding(
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
                    )
                  ],
                ),
              ),
            ),
            //GenerateScreen(_dataString)
            Expanded(
              child: Center(
                child: RepaintBoundary(
                  key: globalKey,
                  child: QrImage(
                    data: _dataString,
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
          ],
        ));
  }
}
