import 'dart:typed_data';

String convertToSimplePhoneNumber(String inputString) {
  if (inputString.isEmpty) return "";
  String newStr = inputString;
  newStr = newStr.replaceAll('(', '');
  newStr = newStr.replaceAll(')', '');
  newStr = newStr.replaceAll(' ', '');
  newStr = newStr.replaceAll('-', '');
  print(newStr);
  return newStr;
}

//TODO: Реализовать функцию преобразования из простого номера в удобочитаемый
String convertFromSimplePhoneNumber(String inputString) {
  if (inputString.isEmpty) return "";
  inputString = convertToSimplePhoneNumber(inputString);
  String newStr =
      "${inputString.substring(0, 2)} (${inputString.substring(2, 5)}) ${inputString.substring(5, 8)}-${inputString.substring(8, 10)}-${inputString.substring(10, 12)}";
  return newStr;
}
