//change theme alert dialog
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_forecast/provider/theme.dart';

void showThemeSelectDialog(BuildContext context) {
  final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

  showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          title: Text('select-theme'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.light_mode, color: Colors.amber),
                title: Text('light'.tr()),
                onTap: () {
                  if (themeProvider.isDarkMode) {
                    themeProvider.toggleTheme();
                  }
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.dark_mode, color: Colors.blueGrey),
                title: Text('dark'.tr()),
                onTap: () {
                  if (!themeProvider.isDarkMode) {
                    themeProvider.toggleTheme();
                  }
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
  );
}
