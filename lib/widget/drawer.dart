import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_forecast/screen/static/settings.dart';
import '../provider/favorite.dart';

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.settings),
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
              ],
            ),
          ),
          if (favorites.isEmpty)
            const ListTile(
              title: Text("Henüz favori şehir yok"),
              leading: Icon(Icons.star_border),
            )
          else
            ...favorites.map(
              (city) => ListTile(
                title: Text(city),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    favoriteProvider.removeFavorite(city);
                  },
                ),
                onTap: () {
                  // TODO: O şehre geçiş yapılacaksa burada yapılabilir
                },
              ),
            ),
        ],
      ),
    );
  }
}
