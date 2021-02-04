import 'package:flutter/material.dart';
import 'package:Tigra/screens/authorisation_screen.dart';
import 'package:Tigra/styles/theme.dart';

class PassChangeContainer extends StatefulWidget {
  final TextEditingController _firstPassController;
  final TextEditingController _secondPassController;
  PassChangeContainer(this._firstPassController, this._secondPassController);
  @override
  _PassChangeContainer createState() => _PassChangeContainer();
}

class _PassChangeContainer extends State<PassChangeContainer> {
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
          Form(
            key: AppKeys.keys2,
            child: Container(
              height: 41,
              width: 240,
              child: TextFormField(
                //initialValue: "+79033064659",
                controller: widget._firstPassController,
                validator: (str) {
                  if (str.length < 6) {
                    return "Пароль слишком короткий";
                  } else if (!str.contains(new RegExp(r'[0-9]'))) {
                    return "Пороль должен содержать хотя-бы одну цифру";
                  } else if (!str.contains(new RegExp(r'[a-x]'))) {
                    return "Пароль должен содержать хотя-бы одну букву латинского алфавита";
                  } else if (str.length > 32) {
                    return "Пароль слишком длинный";
                  } else {
                    return null;
                  }
                },
                //inputFormatters: [maskFormatter],
                decoration: inputDecor("Новый пароль"),
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.bottom,
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Form(
            key: AppKeys.keys3,
            child: Container(
              height: 41,
              width: 240,
              child: TextFormField(
                //initialValue: "+79033064659",
                controller: widget._secondPassController,
                validator: (str) {
                  if (str.length < 6) {
                    return "Пароль слишком короткий";
                  } else if (!str.contains(new RegExp(r'[0-9]'))) {
                    return "Пороль должен содержать хотя-бы одну цифру";
                  } else if (!str.contains(new RegExp(r'[a-x]'))) {
                    return "Пароль должен содержать хотя-бы одну букву латинского алфавита";
                  } else if (str.length > 32) {
                    return "Пароль слишком длинный";
                  } else {
                    return null;
                  }
                },
                //inputFormatters: [maskFormatter],
                decoration: inputDecor("Подтвердите пароль"),
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.bottom,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
