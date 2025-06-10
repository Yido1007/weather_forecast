import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/weather.dart';
import '../provider/favorite.dart';

class WeatherInfo extends StatelessWidget {
  final Weather weather;

  const WeatherInfo({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  weather.cityName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Consumer<FavoriteProvider>(
                  builder: (context, favoriteProvider, _) {
                    final isFavorite = favoriteProvider.isFavorite(
                      weather.cityName,
                    );
                    return IconButton(
                      icon: Icon(
                        isFavorite ? Icons.star : Icons.star_border,
                        color: isFavorite ? Colors.amber : Colors.grey,
                      ),
                      onPressed: () {
                        if (isFavorite) {
                          favoriteProvider.removeFavorite(weather.cityName);
                        } else {
                          favoriteProvider.addFavorite(weather.cityName);
                        }
                      },
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 10),
            Image.network(
              'https://openweathermap.org/img/wn/${weather.iconCode}@2x.png',
              width: 80,
              height: 80,
            ),
            const SizedBox(height: 10),
            Text(
              "${weather.temperature.toStringAsFixed(1)}°C",
              style: const TextStyle(fontSize: 32),
            ),
            Text(weather.description, style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
