import 'package:Tigra/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class TransparentLoader extends StatefulWidget {
  @override
  _TransparentLoaderState createState() => _TransparentLoaderState();
}

class _TransparentLoaderState extends State<TransparentLoader> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Material(
      type: MaterialType.transparency,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50.0,
              width: 50.0,
              child: SpinKitCircle(
                size: 50,
                color: kBottomColorOrange,
              ),
            )
          ],
        ),
      ),
    ));
  }
}
