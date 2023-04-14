import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo2/ui/app_config_provider.dart';

import '../ui/homescreen.dart';

void addShowMessage(String message, BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (buildContext) {
        return AlertDialog(
          backgroundColor: Provider.of<AppConfigProvider>(context)
              .containerBackgroundColor(),
          content: Text(message, style: Theme.of(context).textTheme.titleSmall),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    HomeScreen.routName,
                    (route) => false,
                  );
                },
                child:
                    Text('OK', style: Theme.of(context).textTheme.titleSmall))
          ],
        );
      });
}
