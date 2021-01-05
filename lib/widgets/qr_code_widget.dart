import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:tigra/styles/theme.dart';

class GenerateScreen extends StatefulWidget {
  String _dataString;
  GenerateScreen(this._dataString);
  @override
  State<StatefulWidget> createState() => _GenerateScreenState();
}

class _GenerateScreenState extends State<GenerateScreen> {
  GlobalKey globalKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: _contentWidget(),
    );
  }

  /*Future<void> _captureAndSharePng() async {
    try {
      RenderRepaintBoundary boundary = globalKey.currentContext.findRenderObject();
      var image = await boundary.toImage();
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await new File('${tempDir.path}/image.png').create();
      await file.writeAsBytes(pngBytes);

      final channel = const MethodChannel('channel:me.alfian.share/share');
      channel.invokeMethod('shareFile', 'image.png');

    } catch(e) {
      print(e.toString());
    }
  }*/

  _contentWidget() {
    final bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewInsets.bottom;
    return Expanded(
      child: Center(
        child: RepaintBoundary(
          key: globalKey,
          child: QrImage(
            data: widget._dataString,
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
    );
  }
}
