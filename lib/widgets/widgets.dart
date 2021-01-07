import 'package:flutter/material.dart';
import 'package:tigra/blocs/user_auth_bloc.dart';
import 'package:tigra/styles/theme.dart';
import 'package:tigra/main.dart';

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
            automaticallyImplyLeading: false,
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
  final child;
  final Function funct;

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

class CostomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  CostomTextField(this.controller, this.hintText);
  @override
  _CostomTextFieldState createState() => _CostomTextFieldState();
}

class _CostomTextFieldState extends State<CostomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey,
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: Colors.white,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(2.5)),
          borderSide: BorderSide.none,
        ),
      ),
      style: TextStyle(color: Colors.white, fontSize: 16),
    );
  }
}
