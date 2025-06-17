// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:weather_forecast/screen/client/locations.dart';
import 'package:weather_forecast/screen/static/settings.dart';
import 'package:weather_forecast/widget/drawer/drawer_item.dart';

class AppDrawer extends StatelessWidget {
  final Function(String) onCitySelected;
  const AppDrawer({super.key, required this.onCitySelected});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          //Favorite Cities
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
          //Settings
          DrawerItem(
            icon: Icons.settings,
            title: "Ayarlar",
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
