import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/weather.dart';
import '../provider/favorite.dart';
import '../provider/weather.dart';
import '../screen/static/settings.dart';

class AppDrawer extends StatelessWidget {
  final Function(String) onCitySelected;
  const AppDrawer({super.key, required this.onCitySelected});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "title-2".tr(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 20,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.settings,
                    color: Theme.of(context).colorScheme.onError,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<FavoriteProvider>(
              builder: (context, favoriteProvider, _) {
                final favoriteCities = favoriteProvider.favorites;
                if (favoriteCities.isEmpty) {
                  return const Center(child: Text('Favori şehir yok.'));
                }
                return ListView.builder(
                  itemCount: favoriteCities.length,
                  itemBuilder: (context, index) {
                    final cityName = favoriteCities[index];
                    return Dismissible(
                      key: Key(cityName),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Theme.of(context).colorScheme.error,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Icon(
                          Icons.delete,
                          color: Theme.of(context).colorScheme.onError,
                        ),
                      ),
                      onDismissed: (direction) {
                        favoriteProvider.removeFavorite(cityName);
                      },
                      child: FutureBuilder<WeatherData>(
                        future: Provider.of<WeatherProvider>(
                          context,
                          listen: false,
                        ).fetchWeatherData(cityName),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const ListTile(title: Text("Yükleniyor..."));
                          } else if (snapshot.hasError || !snapshot.hasData) {
                            return ListTile(
                              title: Text(cityName),
                              subtitle: const Text("Veri alınamadı"),
                            );
                          } else {
                            final weather = snapshot.data!;
                            return ListTile(
                              leading: Image.network(
                                weather.iconUrl,
                                width: 40,
                              ),
                              title: Text(weather.cityName),
                              subtitle: Text('${weather.temperature}°C'),
                              onTap: () {
                                onCitySelected(cityName);
                                Navigator.pop(context);
                              },
                            );
                          }
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
