import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/weather.dart';
import '../provider/favorite.dart';
import '../provider/weather.dart';
import '../screen/static/settings.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final favorites = favoriteProvider.favorites;

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.blue),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "🌤️ Hava Durumu",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                IconButton(
                  icon: const Icon(Icons.settings, color: Colors.white),
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
                      direction:
                          DismissDirection.endToStart, // sağdan sola kaydırma
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Icon(Icons.delete, color: Colors.white),
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
                                Provider.of<WeatherProvider>(
                                  context,
                                  listen: false,
                                ).fetchWeather(cityName);
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
