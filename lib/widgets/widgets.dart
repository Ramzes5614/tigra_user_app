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
  Function funct;

  MainButton({@required this.child, @required this.funct});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: funct,
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
      child: child,
      color: themeLight.buttonColor,
    );
  }
}

class MyIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.check_box_outline_blank_rounded,
      size: 50,
      color: themeLight.buttonColor,
    );
  }
}

class VisitsColumn extends StatelessWidget {
  final int remainder;

  VisitsColumn({@required this.remainder});

  List<Widget> getCheckBoxColumn() {
    List<Widget> list = List<Widget>();
    /*for (int i = 0; i < 5 - remainder; i++) {
      list.add(Expanded(
        child: Icon(Icons.check_box_outline_blank_rounded),
      ));
    }*/
    list.add(MyIcon());
    list.add(MyIcon());
    list.add(MyIcon());
    list.add(MyIcon());
    list.add(MyIcon());

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: getCheckBoxColumn(),
    );
  }
}

Widget CostomTextField(TextEditingController controller, String hintText) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      hintText: hintText,
      border: OutlineInputBorder(),
      fillColor: Colors.black45,
      focusColor: Colors.black38,
    ),
    style: TextStyle(color: Colors.white, fontSize: 16),
  );
}
