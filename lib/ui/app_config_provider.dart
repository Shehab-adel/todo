import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';

class AppConfigProvider extends ChangeNotifier {
  String appLanguage = 'en';
  ThemeMode appTheme = ThemeMode.light;
  late SharedPreferences prefs;

  void changeAppLanguage(String newLang) async {
    prefs = await SharedPreferences.getInstance();
    if (newLang == appLanguage) {
      return;
    }
    appLanguage = newLang;
    prefs.setString('lang', appLanguage);
    notifyListeners();
  }

  bool isDark() {
    return appTheme == ThemeMode.dark;
  }

  void changeAppThemeMode(ThemeMode newMode) async {
    prefs = await SharedPreferences.getInstance();
    if (appTheme == newMode) {
      return;
    }
    appTheme = newMode;
    prefs.setString('theme', appTheme == ThemeMode.dark ? 'dark' : 'light');
    notifyListeners();
  }

  Color containerBackgroundColor() {
    return isDark() ? MyThemeData.darkScaffoldBackground : Colors.white;
  }

  Color bottomSheetTextColor() {
    return isDark() ? Colors.white : Colors.black;
  }
}
