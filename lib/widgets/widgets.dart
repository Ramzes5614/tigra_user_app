import 'package:flutter/material.dart';
import 'package:tigra/styles/theme.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final Text text;
  final TextButton button;

  const MainAppBar({
    Key key,
    @required this.text,
    @required this.button,
    @required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.black,
          child: AppBar(
            backgroundColor: themeLight.appBarTheme.color,
            title: Container(
              padding: EdgeInsets.all(5),
              child: text,
            ),
            actions: [
              Padding(
                padding: EdgeInsets.all(5),
                child: button,
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class MainButton extends StatelessWidget {
  var child;

  MainButton({@required this.child});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {},
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
      child: child,
      color: themeLight.buttonColor,
    );
  }
}
