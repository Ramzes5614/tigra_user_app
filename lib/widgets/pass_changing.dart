import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:tigra/screens/authorisation_screen.dart';
import 'package:tigra/styles/theme.dart';

class PassChangeContainer extends StatefulWidget {
  @override
  _PassChangeContainer createState() => _PassChangeContainer();
}

class _PassChangeContainer extends State<PassChangeContainer> {
  TextEditingController _loginController = TextEditingController();
  //var maskFormatter = new MaskTextInputFormatter(
  // mask: '+# (###) ###-##-##', filter: {"#": RegExp(r'[0-9]')});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Придумайте новый пароль",
            style: kSurnameTextStyle,
          ),
          SizedBox(
            height: 10,
          ),
          Text("Не забудьте его сохранить!",
              style: kSurnameTextStyle.copyWith(
                  color: Color(0xFF313131).withOpacity(0.5))),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 41,
            width: 240,
            child: TextFormField(
              //initialValue: "+79033064659",
              controller: _loginController,
              validator: (str) {
                if (str.length == 0) {
                  return "Введите новый пароль";
                } else {
                  return null;
                }
              },
              //inputFormatters: [maskFormatter],
              decoration: inputDecor("Новый пароль"),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 41,
            width: 240,
            child: TextFormField(
              //initialValue: "+79033064659",
              controller: _loginController,
              validator: (str) {
                if (str.length == 0) {
                  return "Введите новый пароль";
                } else {
                  return null;
                }
              },
              //inputFormatters: [maskFormatter],
              decoration: inputDecor("Подтвердите пароль"),
            ),
          ),
        ],
      ),
    );
  }
}
