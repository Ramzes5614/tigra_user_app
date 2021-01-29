import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:tigra/screens/authorisation_screen.dart';
import 'package:tigra/styles/theme.dart';

class PhoneEnterContainer extends StatefulWidget {
  final Key key;
  final TextEditingController _loginController;
  PhoneEnterContainer(this._loginController, this.key);
  @override
  _PhoneEnterContainerState createState() => _PhoneEnterContainerState();
}

class _PhoneEnterContainerState extends State<PhoneEnterContainer> {
  var maskFormatter = new MaskTextInputFormatter(
      mask: '+# (###) ###-##-##', filter: {"#": RegExp(r'[0-9]')});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Подтвердите ваш номер телефона",
            style: kSurnameTextStyle,
          ),
          SizedBox(
            height: 30,
          ),
          Form(
            key: widget.key,
            child: Container(
              width: 240,
              height: 41,
              child: TextFormField(
                //initialValue: "+79033064659",
                controller: widget._loginController,
                validator: (str) {
                  if (str.length == 0) {
                    return "Введите номер телефона";
                  } else if (str[1] != '7') {
                    return "Введите номер с кодом +7";
                  } else {
                    return null;
                  }
                },
                inputFormatters: [maskFormatter],
                decoration: inputDecor("Номер телефона"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
