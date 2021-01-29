import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:tigra/elements/methods.dart';
import 'package:tigra/main.dart';
import 'package:tigra/models/user_model.dart';
import 'package:tigra/repos/app_repository.dart';
import 'package:tigra/responses/user_response.dart';
import 'package:tigra/styles/theme.dart';
import 'package:tigra/widgets/recovery_code_enter_widget.dart';

class RegistrationScreen extends StatefulWidget {
  UserModel user;
  RegistrationScreen(this.user);
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _codeController = TextEditingController();
  AppRepository _appRepository = AppRepository();

  var maskFormatter = new MaskTextInputFormatter(
      mask: '+# (###) ###-##-##', filter: {"#": RegExp(r'[0-9]')});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () => authorisationBloc.pickState(UserUnAuth()),
        child: SafeArea(
          child: Center(
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "Регистрация",
                      style: kTitleTextStyle,
                    ),
                  ),
                  CodeEnterWidget(
                    codeController: _codeController,
                    key: keys.formLoginKeys[10],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (!keys.formLoginKeys[10].currentState.validate()) {
                        return;
                      }
                      if (await _appRepository.codeCheckBool(
                          convertToSimplePhoneNumber(
                              widget.user.userPhoneNumber),
                          _codeController.text)) {
                        authorisationBloc.pickState(UserUnAuth());
                      }
                    },
                    child: Container(
                      height: 41,
                      width: 240,
                      decoration: kOrangeBoxDecorationOrangeBorder,
                      padding: EdgeInsets.all(5),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Зарегистрироваться",
                          style: kBottomTextStyleWhite,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
