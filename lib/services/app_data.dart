import 'package:flutter/material.dart';

class AppData with ChangeNotifier {
  bool _isDarkTheme = false;

  bool get isDarkTheme => _isDarkTheme;

  set isDarkTheme(bool value) {
    _isDarkTheme = value;
    notifyListeners();
  }
}

class AppTheme {
  static final ThemeData light = ThemeData(
    backgroundColor: Colors.white,
    primaryColor: Colors.green,
    accentColor: Colors.greenAccent,
    brightness: Brightness.light,
  );

  static final ThemeData dark = ThemeData(
    backgroundColor: Colors.black,
    primaryColor: Colors.white,
    accentColor: Colors.white,
    brightness: Brightness.dark,
  );
}
