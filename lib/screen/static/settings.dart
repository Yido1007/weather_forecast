import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_forecast/provider/units/pressure.dart';
import 'package:weather_forecast/provider/units/temperature.dart';
import 'package:weather_forecast/provider/units/wind.dart';
import 'package:weather_forecast/screen/core/startup.dart';
import 'package:weather_forecast/service/permission.dart';
import 'package:weather_forecast/service/units/pressure.dart';
import 'package:weather_forecast/service/units/temperature.dart';
import 'package:weather_forecast/service/units/wind.dart';
import 'package:weather_forecast/widget/dialog/language.dart';
import 'package:weather_forecast/widget/dialog/pressure.dart';
import 'package:weather_forecast/widget/dialog/temperature.dart';
import 'package:weather_forecast/widget/dialog/theme.dart';
import 'package:weather_forecast/widget/dialog/wind.dart';
import 'package:weather_forecast/widget/settings/text.dart';
import 'package:weather_forecast/widget/settings/unit_selector.dart';

class SettingsScreen extends StatelessWidget {
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
