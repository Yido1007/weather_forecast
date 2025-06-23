import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_forecast/provider/units/pressure.dart';
import 'package:weather_forecast/provider/units/temperature.dart';
import 'package:weather_forecast/provider/units/wind.dart';
import 'package:weather_forecast/screen/core/startup.dart';
import 'package:weather_forecast/provider/theme.dart';
import 'package:weather_forecast/service/permission.dart';
import 'package:weather_forecast/service/units/pressure.dart';
import 'package:weather_forecast/service/units/temperature.dart';
import 'package:weather_forecast/service/units/wind.dart';
import 'package:weather_forecast/widget/settings/text.dart';
import 'package:weather_forecast/widget/settings/unit_selector.dart';

class SettingsScreen extends StatelessWidget {
  //pressure unit alert dialog
  void showPressureUnitDialog(BuildContext context) {
    final unitProvider = Provider.of<PressureUnitProvider>(
      context,
      listen: false,
    );
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('select-press-unit'.tr()),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<PressureUnit>(
                title: Text("hpa".tr()),
                value: PressureUnit.hpa,
                groupValue: unitProvider.pressureUnit,
                onChanged: (value) {
                  if (value != null) {
                    unitProvider.setPressureUnit(value);
                    Navigator.pop(context);
                  }
                },
              ),
              RadioListTile<PressureUnit>(
                title: Text("mmhg".tr()),
                value: PressureUnit.mmhg,
                groupValue: unitProvider.pressureUnit,
                onChanged: (value) {
                  if (value != null) {
                    unitProvider.setPressureUnit(value);
                    Navigator.pop(context);
                  }
                },
              ),
              RadioListTile<PressureUnit>(
                title: Text('atm'.tr()),
                value: PressureUnit.atm,
                groupValue: unitProvider.pressureUnit,
                onChanged: (value) {
                  if (value != null) {
                    unitProvider.setPressureUnit(value);
                    Navigator.pop(context);
                  }
                },
              ),
              RadioListTile<PressureUnit>(
                title: Text('psi'.tr()),
                value: PressureUnit.psi,
                groupValue: unitProvider.pressureUnit,
                onChanged: (value) {
                  if (value != null) {
                    unitProvider.setPressureUnit(value);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  //temperature unit alert dialog
  void showTemperatureUnitDialog(BuildContext context) {
    final unitProvider = Provider.of<TemperatureUnitProvider>(
      context,
      listen: false,
    );
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('select-temp-unit'.tr()),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<TemperatureUnit>(
                title: Text('celsius'.tr()),
                value: TemperatureUnit.celsius,
                groupValue: unitProvider.unit,
                onChanged: (value) {
                  if (value != null) {
                    unitProvider.setUnit(value);
                    Navigator.pop(context);
                  }
                },
              ),
              RadioListTile<TemperatureUnit>(
                title: const Text('Fahrenheit (°F)'),
                value: TemperatureUnit.fahrenheit,
                groupValue: unitProvider.unit,
                onChanged: (value) {
                  if (value != null) {
                    unitProvider.setUnit(value);
                    Navigator.pop(context);
                  }
                },
              ),
              RadioListTile<TemperatureUnit>(
                title: const Text('Kelvin (K)'),
                value: TemperatureUnit.kelvin,
                groupValue: unitProvider.unit,
                onChanged: (value) {
                  if (value != null) {
                    unitProvider.setUnit(value);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  //wind unit alert dialog
  void showWindSpeedUnitDialog(BuildContext context) {
    final unitProvider = Provider.of<WindSpeedUnitProvider>(
      context,
      listen: false,
    );
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('select-wind-unit'.tr()),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<WindSpeedUnit>(
                title: Text('km/hour'.tr()),
                value: WindSpeedUnit.kmh,
                groupValue: unitProvider.windSpeedUnit,
                onChanged: (value) {
                  if (value != null) {
                    unitProvider.setWindSpeedUnit(value);
                    Navigator.pop(context);
                  }
                },
              ),
              RadioListTile<WindSpeedUnit>(
                title: Text('m/s'.tr()),
                value: WindSpeedUnit.ms,
                groupValue: unitProvider.windSpeedUnit,
                onChanged: (value) {
                  if (value != null) {
                    unitProvider.setWindSpeedUnit(value);
                    Navigator.pop(context);
                  }
                },
              ),
              RadioListTile<WindSpeedUnit>(
                title: Text('m/s'.tr()),
                value: WindSpeedUnit.mph,
                groupValue: unitProvider.windSpeedUnit,
                onChanged: (value) {
                  if (value != null) {
                    unitProvider.setWindSpeedUnit(value);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  //change language alert dialog
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

  //change theme alert dialog
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

  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //temperature Provider
    final unitProvider = Provider.of<TemperatureUnitProvider>(context);
    final tempUnitProvider = Provider.of<TemperatureUnitProvider>(context);
    final tempUnit = tempUnitProvider.unit;
    final tempUnitName = temperatureUnitFullName(tempUnit);
    //pressure Provider
    final pressureUnitProvider = Provider.of<PressureUnitProvider>(context);
    final pressureUnit = pressureUnitProvider.pressureUnit;
    final pressureUnitName = pressureUnitFullName(pressureUnit);
    //wind provider
    final windSpeedProvider = Provider.of<WindSpeedUnitProvider>(context);
    final windSpeedUnit = windSpeedProvider.windSpeedUnit;
    final windSpeedUnitName = windSpeedUnitFullName(windSpeedUnit);
    //theme
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(title: Text('settings'.tr())),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Theme
            SettingText(title: "theme".tr()),
            SettingUnitRow(
              icon: isDark ? Icons.nightlight_round : Icons.wb_sunny,
              iconColor: isDark ? Colors.amber : Colors.deepOrange,
              title: "theme".tr(),
              subtitle: isDark ? "dark".tr() : "light".tr(),
              onTap: () => showThemeSelectDialog(context),
            ),
            Divider(thickness: 2),
            //units
            SettingText(title: "units".tr()),
            //Temperature unit
            SettingUnitRow(
              icon: Icons.thermostat,
              iconColor: Colors.redAccent.shade200,
              title: "temperature_unit".tr(),
              subtitle: tempUnitName.tr(),
              onTap: () => showTemperatureUnitDialog(context),
            ),
            //Pressure unit
            SettingUnitRow(
              icon: Icons.speed,
              iconColor: Colors.blueAccent,
              title: "pressure_unit".tr(),
              subtitle: pressureUnitName.tr(),
              onTap: () => showPressureUnitDialog(context),
            ),
            //Wind unit
            SettingUnitRow(
              icon: Icons.air,
              iconColor: Colors.green.shade400,
              title: "wind_unit".tr(),
              subtitle: windSpeedUnitName.tr(),
              onTap: () => showWindSpeedUnitDialog(context),
            ),
            Divider(thickness: 2),
            //Language
            SettingText(title: "lang".tr()),
            //Change language
            SettingUnitRow(
              icon: Icons.language,
              iconColor: Colors.orange,
              title: "app-lang".tr(),
              subtitle: () {
                switch (context.locale.languageCode) {
                  case 'tr':
                    return 'Türkçe';
                  case 'en':
                    return 'English';
                  case 'es':
                    return 'Español';
                  case 'fr':
                    return 'Français';
                  case 'de':
                    return 'Deutsch';
                  case "it":
                    return "Italiano";
                  default:
                    return context.locale.languageCode;
                }
              }(),
              onTap: () => showLanguageSelectDialog(context),
            ),
            //Permission
            SettingText(title: "permission".tr()),
            Divider(thickness: 2),
            SettingUnitRow(
              icon: Icons.my_location,
              iconColor: Colors.blueAccent,
              title: 'location-permission'.tr(),
              subtitle: 'grant-location'.tr(),
              onTap: () => requestLocationPermission(context),
            ),
            // Onboarding Reset
            ElevatedButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.remove('boarding_shown');
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const StartupRouter()),
                  (route) => false,
                );
              },
              child: const Text("Onboarding Sıfırla"),
            ),
          ],
        ),
      ),
    );
  }
}
