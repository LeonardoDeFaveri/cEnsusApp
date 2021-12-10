const int _shift = 2;

String encode(String password) {
  StringBuffer result = StringBuffer();
  for (var i = 0; i < password.length; i++) {
    result.write(password.codeUnitAt(i) + _shift);
  }
  return result.toString();
}

String decode(String password) {
  StringBuffer result = StringBuffer();
  for (var i = 0; i < password.length; i++) {
    result.write(password.codeUnitAt(i) - _shift);
  }
  return result.toString();
}

class ExcelException implements Exception {}
