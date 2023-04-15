import '../main.dart';

String getAppLanguageFromSharedPrefres() {
  return prefs.getString('lang') == 'en' ? 'en' : 'ar';
}
