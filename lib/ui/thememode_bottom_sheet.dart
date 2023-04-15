import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'app_config_provider.dart';

class ThemeModeBottomSheet extends StatefulWidget {
  const ThemeModeBottomSheet({Key? key}) : super(key: key);

  @override
  State<ThemeModeBottomSheet> createState() => _ThemeModeBottomSheetState();
}

class _ThemeModeBottomSheetState extends State<ThemeModeBottomSheet> {
  late AppConfigProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppConfigProvider>(context);
    return Container(
      padding: const EdgeInsets.all(12),
      color: provider.containerBackgroundColor(),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              provider.changeAppThemeMode(ThemeMode.light);
            },
            child: provider.appTheme == ThemeMode.light
                ? selecteThemeMode(AppLocalizations.of(context)!.light)
                : unSelecteThemeMode(AppLocalizations.of(context)!.light),
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              provider.changeAppThemeMode(ThemeMode.dark);
            },
            child: provider.appTheme == ThemeMode.dark
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
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontSize: 20,
                color: provider.bottomSheetTextColor(),
              ),
        ),
        Icon(
          Icons.check,
          color: provider.bottomSheetTextColor(),
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
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontSize: 20,
                color: provider.bottomSheetTextColor(),
              ),
        ),
      ],
    );
  }
}
