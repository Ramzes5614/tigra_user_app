import 'package:flutter/material.dart';

ThemeData themeLight = ThemeData(
    backgroundColor: Color(0xFFE5E5E5),
    appBarTheme: AppBarTheme(color: Color(0xFF171717)));

const kBottomColorOrange = Color(0xFFFF8B20);
const kBottomColorWhite = Color(0xFFFFFFFF);
const kBoxBlackColor = Color(0xFF171717);
const kGreenCircleColor = Color(0xFF2ABE30);
const kOrangeCircleColor = Color(0xFFFF8B20);

const String assetName = 'assets/images/tiger.svg';

const kConfirmTextStyle = TextStyle(
    fontFamily: "roboto",
    fontSize: 16,
    color: Color(0xFF171717),
    fontWeight: FontWeight.normal);
const kCircleTextStyle = TextStyle(
    fontFamily: "roboto",
    fontSize: 18,
    color: Color(0xFFFFFFFF),
    fontWeight: FontWeight.normal);
const kBottomTextStyleOrange = TextStyle(
    fontFamily: "roboto",
    fontSize: 18,
    color: Color(0xFFFF8B20),
    fontWeight: FontWeight.bold);
const kBottomTextStyleWhite = TextStyle(
    fontFamily: "roboto",
    fontSize: 18,
    color: Color(0xFFFFFFFF),
    fontWeight: FontWeight.bold);
const kHelpBottomTextStyleBlack = TextStyle(
    fontFamily: "roboto",
    fontSize: 18,
    color: Color(0xFF171717),
    fontWeight: FontWeight.bold);
const kTitleTextStyle = TextStyle(
    fontFamily: "roboto",
    fontSize: 36,
    color: Color(0xFF171717),
    fontWeight: FontWeight.normal);
const kHintTextStyle = TextStyle(
    fontFamily: "roboto",
    fontSize: 36,
    color: Color(0xFF171717),
    fontWeight: FontWeight.normal);
const kErrorTextStyle = TextStyle(
    fontFamily: "roboto",
    fontSize: 15,
    color: Color(0xFFFF8B20),
    fontWeight: FontWeight.normal);
const kNameTextStyle = TextStyle(
    fontFamily: "roboto",
    fontSize: 26,
    color: Color(0xFF171717),
    fontWeight: FontWeight.normal);
const kSurnameTextStyle = TextStyle(
    fontFamily: "roboto",
    fontSize: 18,
    color: Color(0xFF171717),
    fontWeight: FontWeight.normal);
const kSurnameTextStyleWhite = TextStyle(
    fontFamily: "roboto",
    fontSize: 18,
    color: Color(0xFFFFFFFF),
    fontWeight: FontWeight.normal);
const kVisitsNumberTextStyle = TextStyle(
    fontFamily: "roboto",
    fontSize: 144,
    color: Color(0xFFFF8B20),
    fontWeight: FontWeight.normal);
const kVisitsTextStyle = TextStyle(
    fontFamily: "roboto",
    fontSize: 18,
    color: Color(0xFFFF8B20),
    fontWeight: FontWeight.normal);
const kDoubleSendTextStyle = TextStyle(
    fontFamily: "roboto",
    fontSize: 15,
    color: Color(0xFFFF8B20),
    fontWeight: FontWeight.normal);
BoxDecoration kOrangeBoxDecorationOrangeBorder = BoxDecoration(
    color: Color(0xFFFF8B20),
    borderRadius: BorderRadius.circular(6),
    border: Border.all(
      color: Color(0xFFFF8B20),
      width: 3.0,
    ));
BoxDecoration kWhiteBoxDecorationOrangeBorder = BoxDecoration(
    color: Color(0xFFFFFFFF),
    borderRadius: BorderRadius.circular(6),
    border: Border.all(
      color: Color(0xFFFF8B20),
      width: 3.0,
    ));
BoxDecoration kWhiteBoxDecorationBlackBorder = BoxDecoration(
    color: Color(0xFFFFFFFF),
    borderRadius: BorderRadius.circular(6),
    border: Border.all(
      color: Color(0xFF171717),
      width: 3.0,
    ));
BoxDecoration kCircleDecoration = BoxDecoration(shape: BoxShape.circle);
BoxDecoration kAppBarBottomBoxDecoration = BoxDecoration(
    color: Color(0xFFFFFFFF),
    borderRadius: BorderRadius.circular(6),
    border: Border.all(
      color: Color(0xFFFFFFFF),
      width: 3.0,
    ));

const String helperText =
    "Если вы уверены в правильности набранного пароля и номера телефона при входе, либо возникли сложности при регистрации, вы можете связаться с администрацией в ближайшем ИЦ либо через:";
const String helperTextContacts =
    "mail@tigra-kzn.ru\n+7 843 249 59 62\n+7 927 249 59 62";

const kHelperContactsTextStyle = TextStyle(
    fontFamily: "roboto",
    fontSize: 18,
    color: kBoxBlackColor,
    fontWeight: FontWeight.bold);

class AppKeys {
  static final keys0 = GlobalKey<FormState>(debugLabel: '_auth_login');
  static final keys1 = GlobalKey<FormState>(debugLabel: '_auth_pass');
  static final keys2 = GlobalKey<FormState>(debugLabel: '_passchange1');
  static final keys3 = GlobalKey<FormState>(debugLabel: '_passchenge2');
  static final keys4 =
      GlobalKey<FormState>(debugLabel: '_registration_surname');
  static final keys5 = GlobalKey<FormState>(debugLabel: '_registration_name');
  static final keys6 =
      GlobalKey<FormState>(debugLabel: '_registration_middle_name');
  static final keys7 = GlobalKey<FormState>(debugLabel: '_registration_phone');
  static final keys8 = GlobalKey<FormState>(debugLabel: '_registration_pass');
  static final keys9 =
      GlobalKey<FormState>(debugLabel: '_registration_code_enter');
  static final keys10 = GlobalKey<FormState>(debugLabel: '_code_enter');
  static final keys11 =
      GlobalKey<FormState>(debugLabel: '_code_enter_reg_screen');
  static final keys12 =
      GlobalKey<FormState>(debugLabel: '_passchange_screen_phone');

  /*List<GlobalKey<FormState>> formLoginKeys = [
    GlobalKey<FormState>(), //0 - авторизация - логин
    GlobalKey<FormState>(), //1 - авторизация - пароль
    /*********************************************/
    GlobalKey<FormState>(), //2 - изменение пароля - 1
    GlobalKey<FormState>(), //3 - изменение пароля - 2
    /*********************************************/
    GlobalKey<FormState>(), //4 - регистрация - фамилия
    GlobalKey<FormState>(), //5 - регистрация - имя
    GlobalKey<FormState>(), //6 - регистрация - отчество
    GlobalKey<FormState>(), //7 - регистрация - телефон
    GlobalKey<FormState>(), //8 - регистрация - пароль
    GlobalKey<FormState>(), //9 - ввод кода - регистрация
    GlobalKey<FormState>(), //10 - ввод кода
    GlobalKey<FormState>(), //11 - ввод кода экран регистрации
    GlobalKey<FormState>() //12 - изменение пароля - телефон
  ];*/
  //final GlobalKey<FormFieldState> txtEmailKey = GlobalKey<FormFieldState>();
}

AppKeys keys = AppKeys();
