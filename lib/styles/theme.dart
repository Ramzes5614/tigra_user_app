import 'package:flutter/material.dart';

ThemeData themeLight = ThemeData(
    backgroundColor: Color(0xFFE5E5E5),
    appBarTheme: AppBarTheme(color: Color(0xFF171717)));

const kBackGroundColor = Color(0xFFFFFFFF);
const kBottomColorOrange = Color(0xFFFF8B20);
const kBottomColorWhite = Color(0xFFFFFFFF);
const kBoxBlackColor = Color(0xFF171717);
const kGreenCircleColor = Color(0xFF2ABE30);
const kOrangeCircleColor = Color(0xFFFF8B20);

const String assetName = 'assets/images/tiger.svg';

const kConfirmTextStyle = TextStyle(
  fontFamily: "roboto",
  fontSize: 26,
  color: Color(0xFF171717),
  fontWeight: FontWeight.w400,
);
const kConfirmButtonTextStyle = TextStyle(
    fontFamily: "roboto",
    fontSize: 16,
    color: Color(0xFF171717),
    fontWeight: FontWeight.w700);
const kConfirmButtonTextStyleWhite = TextStyle(
    fontFamily: "roboto",
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.w700);
const kCircleTextStyle = TextStyle(
    fontFamily: "roboto",
    fontSize: 18,
    color: Color(0xFFFFFFFF),
    fontWeight: FontWeight.normal);
const kBottomTextStyleOrange = TextStyle(
    fontFamily: "roboto",
    fontSize: 18,
    color: Color(0xFFFF8B20),
    fontWeight: FontWeight.w700);
const kBottomTextStyleWhite = TextStyle(
    fontFamily: "roboto",
    fontSize: 18,
    color: Color(0xFFFFFFFF),
    fontWeight: FontWeight.w700);
const kHelpBottomTextStyleBlack = TextStyle(
    fontFamily: "roboto",
    fontSize: 18,
    color: Color(0xFF171717),
    fontWeight: FontWeight.bold);
const kTitleTextStyle = TextStyle(
    fontFamily: "roboto",
    fontSize: 36,
    color: Color(0xFF171717),
    fontWeight: FontWeight.w400);
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
const kKidNameTextStyle = TextStyle(
    fontFamily: "roboto",
    fontSize: 18,
    color: kGreenCircleColor,
    fontWeight: FontWeight.w400);
const kSurnameTextStyle = TextStyle(
    fontFamily: "roboto",
    fontSize: 18,
    color: Color(0xFF171717),
    fontWeight: FontWeight.w400);
const kHelperTextStyle = TextStyle(
    fontFamily: "roboto",
    fontSize: 18,
    color: Color(0xFF171717),
    fontWeight: FontWeight.w400);
const kSurnameTextStyleWhite = TextStyle(
    fontFamily: "roboto",
    fontSize: 18,
    color: Color(0xFFFFFFFF),
    fontWeight: FontWeight.w400);
const kPreVisitsTextStyle = TextStyle(
    fontFamily: "roboto",
    fontSize: 18,
    color: Color(0xFF171717),
    fontWeight: FontWeight.w400);
const kVisitsNumberTextStyle = TextStyle(
    fontFamily: "roboto",
    fontSize: 144,
    color: Color(0xFFFF8B20),
    fontWeight: FontWeight.bold);
const kVisitsTextStyle = TextStyle(
    fontFamily: "roboto",
    fontSize: 18,
    color: Color(0xFFFF8B20),
    fontWeight: FontWeight.w400);
const kDoubleSendTextStyle = TextStyle(
    fontFamily: "roboto",
    fontSize: 15,
    color: Color(0xFFFF8B20),
    fontWeight: FontWeight.normal);
const kAfterNumTextStyle = TextStyle(
    fontFamily: "roboto",
    fontSize: 21,
    color: Color(0xFFFF8B20),
    fontWeight: FontWeight.w700);
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
    borderRadius: BorderRadius.all(Radius.circular(6)),
    shape: BoxShape.rectangle,
    border: Border.all(
      color: Color(0xFFFFFFFF),
      //width: 0,
    ));

const String helperText =
    "Если вы уверены в правильности набранного пароля и номера телефона при входе, либо возникли сложности при регистрации, вы можете связаться с администрацией в ближайшем ИЦ либо через:";
const String helperTextContacts =
    "mail@tigra-kzn.ru\n+7 843 249 59 62\n+7 927 249 59 62";
const String qrCodeText =
    "Покажите QR-код сотруднику детского игрового центра на кассе для считывания. После считывания мы зачтём посещение для участия в акции";
const kHelperContactsTextStyle = TextStyle(
    fontFamily: "roboto",
    fontSize: 18,
    color: kBoxBlackColor,
    fontWeight: FontWeight.w700);
const kHelperButtonTextStyle = TextStyle(
    fontFamily: "roboto",
    fontSize: 15,
    color: kBoxBlackColor,
    fontWeight: FontWeight.w700);

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
}

AppKeys keys = AppKeys();
