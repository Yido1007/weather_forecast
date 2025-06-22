import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_forecast/provider/units/pressure.dart';
import 'package:weather_forecast/provider/units/temperature.dart';
import 'package:weather_forecast/provider/units/wind.dart';
import 'package:weather_forecast/provider/weather.dart';
import 'package:weather_forecast/screen/core/startup.dart';
import 'package:weather_forecast/provider/theme.dart';
import 'package:weather_forecast/service/units/pressure.dart';
import 'package:weather_forecast/service/units/temperature.dart';
import 'package:weather_forecast/service/units/wind.dart';
import 'package:weather_forecast/widget/unit_selector.dart';

class SettingsScreen extends StatelessWidget {
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

  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
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
    return Scaffold(
      appBar: AppBar(title: Text('settings'.tr())),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Theme Switch
            //ALERT DİALOG İLE GÖSTERİM SAĞLANABİLİR!!
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("theme".tr(), style: const TextStyle(fontSize: 18)),
                Switch(
                  value: themeProvider.isDarkMode,
                  onChanged: (value) {
                    themeProvider.toggleTheme();
                  },
                ),
              ],
            ),
            Divider(thickness: 2),
            //units
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Birimler",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 18,
                ),
              ),
            ),
            //Temperature unit
            SettingUnitRow(
              icon: Icons.thermostat,
              iconColor: Colors.redAccent.shade200,
              title: "temperature_unit".tr(),
              subtitle:
                  tempUnitName.tr(), // örn: temperatureUnitFullName(tempUnit)
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
            // Change Language
            ElevatedButton(
              onPressed: () async {
                await context.setLocale(const Locale('en'));
                final weatherProvider = Provider.of<WeatherProvider>(
                  context,
                  listen: false,
                );
                final currentCity = weatherProvider.weather?.cityName ?? "";
                await weatherProvider.fetchWeather(currentCity, context);
              },
              child: const Text("English"),
            ),
            ElevatedButton(
              onPressed: () async {
                await context.setLocale(const Locale('tr'));
                final weatherProvider = Provider.of<WeatherProvider>(
                  context,
                  listen: false,
                );
                final currentCity = weatherProvider.weather?.cityName ?? "";
                await weatherProvider.fetchWeather(currentCity, context);
              },
              child: const Text("Türkçe"),
            ),
          ],
        ),
      ),
    );
  }
}
