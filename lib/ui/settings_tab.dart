import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo2/functions/get_app_language_from_sharedPrefs.dart';
import 'package:todo2/ui/language_bottom_sheet.dart';
import 'package:todo2/ui/thememode_bottom_sheet.dart';

import 'app_config_provider.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late AppConfigProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppConfigProvider>(context);
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.language,
                style: Theme.of(context).textTheme.displaySmall),
            InkWell(
              onTap: () {
                showLanguageBottomSheet();
              },
              child: Container(
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: provider.containerBackgroundColor(),
                  border: Border.all(color: Colors.blue),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        getAppLanguageFromSharedPrefres() == 'en'
                            ? AppLocalizations.of(context)!.english
                            : AppLocalizations.of(context)!.arabic,
                        style: Theme.of(context).textTheme.headlineMedium),
                    const Icon(
                      Icons.arrow_drop_down_sharp,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
            ),
            Text(
              AppLocalizations.of(context)!.mode,
              style: Theme.of(context).textTheme.displaySmall,
            ),
            InkWell(
              onTap: () {
                showThemeModeBottomSheet();
              },
              child: Container(
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                    color: provider.containerBackgroundColor(),
                    border: Border.all(color: Colors.blueAccent)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        provider.appTheme == ThemeMode.light
                            ? AppLocalizations.of(context)!.light
                            : AppLocalizations.of(context)!.dark,
                        style: Theme.of(context).textTheme.headlineMedium),
                    const Icon(Icons.arrow_drop_down_sharp, color: Colors.blue),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (buildContext) {
          return const LanguageBottomSheet();
        });
  }

  void showThemeModeBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (buildContext) {
          return const ThemeModeBottomSheet();
        });
  }
}
