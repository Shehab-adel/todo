import 'package:flutter/material.dart';

import '../main.dart';

class AppConfigProvider extends ChangeNotifier {
  String appLanguage = 'en';
  ThemeMode appTheme = ThemeMode.light;

  void changeAppLanguage(String newLang) {
    if (newLang == appLanguage) {
      print('$appLanguage************');
      return;
    }
    appLanguage = newLang;
    notifyListeners();
  }

  bool isDark() {
    return appTheme == ThemeMode.dark;
  }

  void changeAppThemeMode(ThemeMode newMode) {
    if (appTheme == newMode) return;
    appTheme = newMode;
    notifyListeners();
  }

  Color containerBackgroundColor() {
    return isDark() ? MyThemeData.darkScaffoldBackground : Colors.white;
  }

  Color bottomSheetTextColor() {
    return isDark() ? Colors.white : Colors.black;
  }
}
