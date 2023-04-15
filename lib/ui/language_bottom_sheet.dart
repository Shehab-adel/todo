import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../functions/get_app_language_from_sharedPrefs.dart';
import 'app_config_provider.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({Key? key}) : super(key: key);

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
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
              provider.changeAppLanguage('en');
            },
            child: getAppLanguageFromSharedPrefres() == 'en'
                ? selectedLanguage(AppLocalizations.of(context)!.english)
                : unSelectedLanguage(AppLocalizations.of(context)!.english),
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              provider.changeAppLanguage('ar');
            },
            child: getAppLanguageFromSharedPrefres() == 'ar'
                ? selectedLanguage(AppLocalizations.of(context)!.arabic)
                : unSelectedLanguage(AppLocalizations.of(context)!.arabic),
          ),
        ],
      ),
    );
  }

  Widget selectedLanguage(String lang) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          lang,
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

  Widget unSelectedLanguage(String lang) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          lang,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontSize: 20,
                color: provider.bottomSheetTextColor(),
              ),
        ),
      ],
    );
  }
}
