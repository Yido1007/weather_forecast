import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_forecast/provider/weather.dart';
import 'package:weather_forecast/screen/core/startup.dart';
import '../../provider/theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('settings'.tr())),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("theme".tr(), style: TextStyle(fontSize: 18)),
                Switch(
                  value: themeProvider.isDarkMode,
                  onChanged: (value) {
                    themeProvider.toggleTheme();
                  },
                ),
              ],
            ),
            // hafıza sıfırlamak için kaldırılcak !!
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
