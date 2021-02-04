import 'dart:ffi';
import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:Tigra/blocs/navigation_bloc.dart';
import 'package:Tigra/blocs/registration_bloc.dart';
import 'package:Tigra/elements/loading_spinkit.dart';
import 'package:Tigra/main.dart';
import 'package:Tigra/models/user_model.dart';
import 'package:Tigra/responses/user_response.dart';
import 'package:Tigra/screens/authorisation_screen.dart';
import 'package:Tigra/styles/theme.dart';
import 'package:Tigra/widgets/recovery_code_enter_widget.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  bool _isCodeSended = false;

  final RegistrationBloc registrationBloc = RegistrationBloc();
  UserModel user;

  var maskFormatter = new MaskTextInputFormatter(
      mask: '+7 (###) ###-##-##', filter: {"#": RegExp(r'[0-9]')});

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    double _statusBar = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: WillPopScope(
        onWillPop: () => authorisationBloc.pickState(UserUnAuth()),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: _size.height - _statusBar,
              width: _size.width,
              color: kBackGroundColor,
              padding: EdgeInsets.fromLTRB(30, 90, 30, 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    //padding: EdgeInsets.all(5),
                    child: Text(
                      "Регистрация",
                      style: kTitleTextStyle,
                    ),
                  ),
                  SizedBox(height: 40),
                  StreamBuilder(
                    stream: registrationBloc.subject,
                    builder: (context, AsyncSnapshot<REGSTATE> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data == REGSTATE.TOREGSCR) {
                          _isCodeSended = false;
                          return _registrationTextFields();
                        } else if (snapshot.data == REGSTATE.LOADING) {
                          return loadingSpinkit();
                        } else if (snapshot.data == REGSTATE.CODESENDED) {
                          _isCodeSended = true;
                          return CodeEnterWidget(
                            codeController: _codeController,
                            onTapF: () => registrationBloc.didNotCame(),
                          );
                        }
                      }
                      return _registrationTextFields();
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    child: StreamBuilder(
                      stream: registrationBloc.subject,
                      builder: (context, AsyncSnapshot<REGSTATE> snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data == REGSTATE.ERROR) {
                            _isCodeSended = false;
                            return AutoSizeText(
                              "Ошибка сервера, повторите позже",
                              overflow: TextOverflow.visible,
                              style: kErrorTextStyle,
                            );
                          } else if (snapshot.data == REGSTATE.CODEERROR) {
                            return AutoSizeText(
                              "Неверный код",
                              overflow: TextOverflow.visible,
                              style: kErrorTextStyle,
                            );
                          } else if (snapshot.data == REGSTATE.ALREADYEXIST) {
                            _isCodeSended = false;
                            return AutoSizeText(
                              "Данный номер телефона уже зарегистрирован",
                              overflow: TextOverflow.visible,
                              style: kErrorTextStyle,
                            );
                          } else if (snapshot.data == REGSTATE.NOUSER) {
                            _isCodeSended = false;
                            return AutoSizeText(
                              "Введите данные пользователя",
                              overflow: TextOverflow.visible,
                              style: kErrorTextStyle,
                            );
                          }
                        }
                        return AutoSizeText(
                          "",
                          overflow: TextOverflow.visible,
                          style: kErrorTextStyle,
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_isCodeSended)
                        _registrationCodeChecking();
                      else
                        _registrationCodeSend();
                    },
                    child: Container(
                      height: 41,
                      width: 240,
                      decoration: kOrangeBoxDecorationOrangeBorder,
                      padding: EdgeInsets.all(5),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Регистрация",
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

  Column _registrationTextFields() {
    return Column(
      children: [
        Form(
          key: AppKeys.keys5,
          child: Container(
            height: 50,
            width: 240,
            padding: EdgeInsets.all(5),
            child: TextFormField(
              textCapitalization: TextCapitalization.words,
              validator: (str) {
                if (str.length == 0) {
                  return "Введите имя";
                }
                return null;
              },
              controller: _nameController,
              decoration: inputDecor("Имя"),
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.bottom,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Form(
          key: AppKeys.keys4,
          child: Container(
            height: 50,
            width: 240,
            padding: EdgeInsets.all(5),
            child: TextFormField(
              textCapitalization: TextCapitalization.words,
              validator: (str) {
                if (str.length == 0) {
                  return "Введите фамилию";
                }
                return null;
              },
              controller: _surnameController,
              decoration: inputDecor("Фамилия"),
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.bottom,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Form(
          key: AppKeys.keys6,
          child: Container(
            height: 50,
            width: 240,
            padding: EdgeInsets.all(5),
            child: TextFormField(
              textCapitalization: TextCapitalization.words,
              validator: (str) {
                if (str.length == 0) {
                  return "Введите отчество";
                }
                return null;
              },
              controller: _middleNameController,
              decoration: inputDecor("Имя ребёнка"),
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.bottom,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Form(
          key: AppKeys.keys7,
          child: Container(
            height: 50,
            width: 240,
            padding: EdgeInsets.all(5),
            child: TextFormField(
              validator: (str) {
                if (str.length < 18) {
                  return "Слишком короткий номер телефона";
                } else if (str[1] != '7') {
                  return "Введите номер с кодом +7";
                } else {
                  return null;
                }
              },
              inputFormatters: [maskFormatter],
              controller: _phoneNumberController,
              decoration: inputDecor("Номер телефона"),
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.bottom,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Form(
          key: AppKeys.keys8,
          child: Container(
            height: 50,
            width: 240,
            padding: EdgeInsets.all(5),
            child: TextFormField(
              validator: (str) {
                if (str.length < 6) {
                  return "Пароль слишком короткий";
                } else if (!str.contains(new RegExp(r'[0-9]'))) {
                  return "Пороль должен содержать\nхотя-бы одну цифру";
                } else if (!str.contains(new RegExp(r'[a-x]'))) {
                  return "Пароль должен содержать хотя-бы\nодну букву латинского алфавита";
                } else if (str.length > 64) {
                  return "Пароль слишком длинный";
                } else {
                  return null;
                }
              },
              controller: _passController,
              decoration: inputDecor("Пароль"),
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.bottom,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: _hasAlreadyCode,
          child: Text(
            "У меня есть код",
            style: kHelperButtonTextStyle,
          ),
        )
      ],
    );
  }

  void _hasAlreadyCode() async {
    bool hasUserData = await registrationBloc.hasUserData();
    if (hasUserData) {
      registrationBloc.pickItem(REGSTATE.CODESENDED);
    }
  }

  void _registrationCodeSend() {
    bool _first = AppKeys.keys4.currentState.validate();
    bool _second = AppKeys.keys5.currentState.validate();
    bool _third = AppKeys.keys6.currentState.validate();
    bool _fourth = AppKeys.keys7.currentState.validate();
    bool _fifth = AppKeys.keys8.currentState.validate();
    if (!_first || !_second || !_third || !_fourth || !_fifth) {
      return;
    }
    user = new UserModel(
        _surnameController.text,
        _nameController.text,
        _middleNameController.text,
        _phoneNumberController.text,
        _passController.text);
    registrationBloc.registrate(user);
  }

  void _registrationCodeChecking() {
    if (!AppKeys.keys10.currentState.validate()) {
      return;
    }
    registrationBloc.codeCheck(_codeController.text);
  }
}
