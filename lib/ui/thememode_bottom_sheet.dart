import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'app_config_provider.dart';

class ThemeModeBottomSheet extends StatefulWidget {
  @override
  State<ThemeModeBottomSheet> createState() => _ThemeModeBottomSheetState();
}

class _ThemeModeBottomSheetState extends State<ThemeModeBottomSheet> {
  late AppConfigProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppConfigProvider>(context);

    return Container(
      padding: EdgeInsets.all(12),
      color: provider.containerbackgroundColor(),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              provider.changeAppThemeMode(ThemeMode.light);
            },
            child: provider.isDark()
                ? unSelecteThemeMode(AppLocalizations.of(context)!.light)
                : selecteThemeMode(AppLocalizations.of(context)!.light),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              provider.changeAppThemeMode(ThemeMode.dark);
            },
            child: provider.isDark()
                ? selecteThemeMode(AppLocalizations.of(context)!.dark)
                : unSelecteThemeMode(AppLocalizations.of(context)!.dark),
          ),
        ],
      ),
    );
  }

  Widget selecteThemeMode(String themeMode) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          themeMode,
          style: Theme.of(context).textTheme.headline4?.copyWith(
            fontSize: 20,
                color: provider.bottomSheettextColor(),
              ),
        ),
        Icon(
          Icons.check,
          color: provider.bottomSheettextColor(),
        ),
      ],
    );
  }

  Widget unSelecteThemeMode(String themeMode) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          themeMode,
          style: Theme.of(context).textTheme.headline4?.copyWith(
            fontSize: 20,
                color: provider.bottomSheettextColor(),
              ),
        ),
      ],
    );
  }
}
