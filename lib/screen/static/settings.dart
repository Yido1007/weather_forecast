import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_forecast/provider/temperature.dart';
import 'package:weather_forecast/provider/weather.dart';
import 'package:weather_forecast/screen/core/startup.dart';
import 'package:weather_forecast/provider/theme.dart';
import 'package:weather_forecast/service/temperature.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final unitProvider = Provider.of<TemperatureUnitProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('settings'.tr())),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
            const Gap(24),
            //Temperature unit
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Sıcaklık Birimi", style: TextStyle(fontSize: 18)),
                PopupMenuButton<TemperatureUnit>(
                  child: Row(
                    children: [
                      Text(unitSymbol(unitProvider.unit)),
                      Icon(Icons.arrow_drop_down),
                    ],
                  ),
                  onSelected: (unit) {
                    unitProvider.setUnit(unit);
                  },
                  itemBuilder:
                      (context) => [
                        PopupMenuItem(
                          value: TemperatureUnit.celsius,
                          child: Text('Santigrat (°C)'),
                        ),
                        PopupMenuItem(
                          value: TemperatureUnit.fahrenheit,
                          child: Text('Fahrenheit (°F)'),
                        ),
                        PopupMenuItem(
                          value: TemperatureUnit.kelvin,
                          child: Text('Kelvin (K)'),
                        ),
                      ],
                ),
              ],
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
