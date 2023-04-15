import 'package:flutter/material.dart';

import '../main.dart';

ThemeMode getAppThemeFromSharedPrefres() {
  return prefs.getString('theme') == 'dark' ? ThemeMode.dark : ThemeMode.light;
}
