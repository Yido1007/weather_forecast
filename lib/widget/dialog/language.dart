//change language alert dialog
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

void showLanguageSelectDialog(BuildContext context) {
  showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          title: Text('select-lang'.tr()),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Text('🇹🇷', style: TextStyle(fontSize: 24)),
                title: const Text('Türkçe'),
                onTap: () async {
                  await context.setLocale(const Locale('tr'));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Text('🇬🇧', style: TextStyle(fontSize: 24)),
                title: const Text('English'),
                onTap: () async {
                  await context.setLocale(const Locale('en'));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Text('🇫🇷', style: TextStyle(fontSize: 24)),
                title: const Text('Français'),
                onTap: () async {
                  await context.setLocale(const Locale('fr'));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Text('🇪🇸', style: TextStyle(fontSize: 24)),
                title: const Text('Español'),
                onTap: () async {
                  await context.setLocale(const Locale('es'));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Text('🇩🇪', style: TextStyle(fontSize: 24)),
                title: const Text('Deutsch'),
                onTap: () async {
                  await context.setLocale(const Locale('de'));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Text('🇮🇹', style: TextStyle(fontSize: 24)),
                title: const Text('Italiano'),
                onTap: () async {
                  await context.setLocale(const Locale('it'));
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
  );
}
