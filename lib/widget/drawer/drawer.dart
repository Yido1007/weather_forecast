import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:weather_forecast/provider/weather.dart';
import 'package:weather_forecast/screen/client/locations.dart';
import 'package:weather_forecast/screen/client/map.dart';
import 'package:weather_forecast/screen/client/news.dart';
import 'package:weather_forecast/screen/static/settings.dart';
import 'package:weather_forecast/widget/drawer/drawer_item.dart';

class AppDrawer extends StatelessWidget {
  final Function(String) onCitySelected;
  const AppDrawer({super.key, required this.onCitySelected});

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset("assets/svg/icon.svg"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                const Icon(Icons.my_location, size: 22),
                const Gap(12),
                Text("current-location").tr(),
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
          // Location text
          if (weatherProvider.useCurrentLocation)
            Padding(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on,
                    size: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const Gap(4),
                  Flexible(
                    child: Text(
                      weatherProvider.detailedLocationName ??
                          "not-location".tr(),
                      style: TextStyle(
                        fontSize: 13,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          //Maps
          DrawerItem(
            icon: Icons.map_rounded,
            title: "maps".tr(),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const WeatherRadarScreen()),
              );
            },
          ),
          // Favorite Cities
          DrawerItem(
            icon: Icons.star,
            title: "fav-location".tr(),
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
          //News
          DrawerItem(
            icon: Icons.newspaper_rounded,
            title: "news".tr(),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const WeatherNewsScreen(),
                ),
              );
            },
          ),
          // Settings
          DrawerItem(
            icon: Icons.settings,
            title: "settings".tr(),
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
