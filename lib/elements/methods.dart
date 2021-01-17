import 'dart:typed_data';

String convertToSimplePhoneNumber(String inputString) {
  if (inputString.isEmpty) return "";
  String newStr = inputString;
  newStr = newStr.replaceAll('(', '');
  newStr = newStr.replaceAll(')', '');
  newStr = newStr.replaceAll(' ', '');
  print(newStr);
  return newStr;
}

//TODO: Реализовать функцию преобразования из простого номера в удобочитаемый
String convertFromSimplePhoneNumber(String inputString) {
  if (inputString.isEmpty) return "";
  String newStr = inputString;

  return newStr;
}
