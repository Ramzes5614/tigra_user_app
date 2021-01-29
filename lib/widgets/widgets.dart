import 'package:flutter/material.dart';
import 'package:Tigra/blocs/user_auth_bloc.dart';
import 'package:Tigra/styles/theme.dart';
import 'package:Tigra/main.dart';

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
            title: text,
            titleSpacing: 30,
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
    return TextFormField(
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

class CircleVisits extends StatefulWidget {
  final int _visits;
  CircleVisits(this._visits);
  @override
  _CircleVisitsState createState() => _CircleVisitsState();
}

class _CircleVisitsState extends State<CircleVisits> {
  final double _litleSize = 15;
  final double _bigSize = 30;
  int _remainder;

  @override
  Widget build(BuildContext context) {
    if (widget._visits == null) {
      _remainder = 0;
    } else {
      _remainder = widget._visits % 5;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: _remainder >= 1 ? _bigSize : _litleSize,
          width: _remainder >= 1 ? _bigSize : _litleSize,
          decoration: kCircleDecoration.copyWith(color: kGreenCircleColor),
          child: Align(
            alignment: Alignment.center,
            child: _remainder >= 1
                ? Text(
                    "1",
                    style: kCircleTextStyle,
                  )
                : null,
          ),
        ),
        Container(
          height: _remainder >= 2 ? _bigSize : _litleSize,
          width: _remainder >= 2 ? _bigSize : _litleSize,
          decoration: kCircleDecoration.copyWith(color: kGreenCircleColor),
          child: Align(
              alignment: Alignment.center,
              child: _remainder >= 2
                  ? Text(
                      "2",
                      style: kCircleTextStyle,
                    )
                  : null),
        ),
        Container(
          height: _remainder >= 3 ? _bigSize : _litleSize,
          width: _remainder >= 3 ? _bigSize : _litleSize,
          decoration: kCircleDecoration.copyWith(color: kGreenCircleColor),
          child: Align(
            alignment: Alignment.center,
            child: _remainder >= 3
                ? Text(
                    "3",
                    style: kCircleTextStyle,
                  )
                : null,
          ),
        ),
        Container(
          height: _remainder >= 4 ? _bigSize : _litleSize,
          width: _remainder >= 4 ? _bigSize : _litleSize,
          decoration: kCircleDecoration.copyWith(color: kGreenCircleColor),
          child: Align(
            alignment: Alignment.center,
            child: _remainder >= 4
                ? Text(
                    "4",
                    style: kCircleTextStyle,
                  )
                : null,
          ),
        ),
        Container(
          height: 30,
          width: 30,
          decoration: kCircleDecoration.copyWith(color: kOrangeCircleColor),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              "5",
              style: kCircleTextStyle,
            ),
          ),
        )
      ],
    );
  }
}
