import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:weather_forecast/provider/weather.dart';
import 'package:weather_forecast/screen/client/locations.dart';
import 'package:weather_forecast/screen/static/settings.dart';
import 'package:weather_forecast/widget/drawer/drawer_item.dart';

class AppDrawer extends StatelessWidget {
  final Function(String) onCitySelected;
  const AppDrawer({super.key, required this.onCitySelected});

  @override
  Widget build(BuildContext context) {
    // listen: true olmalı!
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset("assets/svg/icon.svg"),
          // Switch bölümü
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              children: [
                const Icon(Icons.my_location, size: 22),
                const SizedBox(width: 12),
                const Text("Mevcut Konumu Kullan"),
                const Spacer(),
                Switch(
                  value: weatherProvider.useCurrentLocation,
                  onChanged: (value) {
                    weatherProvider.setUseCurrentLocation(value);
                  },
                ),
              ],
            ),
          ),
          // Konum adı metni
          if (weatherProvider.useCurrentLocation)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                weatherProvider.currentLocationName ?? "Konum alınıyor...",
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          const SizedBox(height: 10),
          // Favorite Cities
          DrawerItem(
            icon: Icons.star,
            title: "Favori Şehirler",
            onTap: () async {
              final selectedCity = await Navigator.push<String>(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => FavoriteLocations(
                        onCitySelected: (city) {
                          Navigator.pop(context, city);
                        },
                      ),
                ),
              );
              if (selectedCity != null && selectedCity.isNotEmpty) {
                onCitySelected(selectedCity);
                Navigator.of(context).pop();
              }
            },
          ),
          // Settings
          DrawerItem(
            icon: Icons.settings,
            title: "Ayarlar",
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
