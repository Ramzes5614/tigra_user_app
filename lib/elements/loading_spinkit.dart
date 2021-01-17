import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoaderSpinkit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 50.0,
            width: 50.0,
            child: SpinKitDoubleBounce(
              size: 50,
              color: Colors.grey,
            ),
          )
        ],
      )),
    );
  }
}

loadingSpinkit() {
  return Container(
    alignment: Alignment.center,
    child: SizedBox(
      height: 50.0,
      width: 50.0,
      child: SpinKitDoubleBounce(
        size: 50,
        color: Colors.grey,
      ),
    ),
  );
}
