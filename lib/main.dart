import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo2/ui/app_config_provider.dart';
import 'package:todo2/ui/edit/editing_task.dart';
import 'package:todo2/ui/homescreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) {
        return AppConfigProvider();
      },
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return MaterialApp(
      title: 'Todo',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(provider.appLanguage),
      theme: provider.isDark() ? MyThemeData.darkTheme : MyThemeData.lightTheme,
      themeMode: provider.appTheme,
      routes: {
        HomeScreen.routName: (buildContext) => const HomeScreen(),
        EditingScreen.routeName: (buildContext) => const EditingScreen(),
      },
      initialRoute: HomeScreen.routName,
    );
  }
}

class MyThemeData {
  static const Color lightScaffoldBackground =
      Color.fromARGB(255, 223, 236, 219);
  static const Color darkScaffoldBackground = Color.fromARGB(255, 6, 14, 30);
  static const Color greenColor = Color.fromARGB(255, 97, 231, 87);

  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: lightScaffoldBackground,
    textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          color: Colors.black45,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          color: Colors.black45,
        ),
        displaySmall: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 14,
        ),
        headlineMedium: TextStyle(
          color: Colors.blue,
          fontSize: 12,
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
        titleSmall: TextStyle(
          fontSize: 16,
          color: Colors.black,
        )),
  );

  static final ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: darkScaffoldBackground,
    primaryColor: MyThemeData.darkScaffoldBackground,
    textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          color: Colors.white54,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          color: Colors.white54,
        ),
        displaySmall: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 14,
        ),
        headlineMedium: TextStyle(
          color: Colors.blue,
          fontSize: 12,
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
        titleSmall: TextStyle(
          fontSize: 16,
          color: Colors.white,
        )),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: MyThemeData.darkScaffoldBackground,
        selectedIconTheme: IconThemeData(
          color: Colors.blue,
        ),
        unselectedIconTheme: IconThemeData(
          color: Colors.white,
        )),
  );
}
