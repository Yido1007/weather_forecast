import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart'; 
import '../../model/weather.dart';
import '../../provider/favorite.dart'; 
import '../../service/lottie_func.dart';
import 'info_item.dart';

class WeatherInfo extends StatelessWidget {
  final Weather weather;
  const WeatherInfo({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final iconColor = Theme.of(context).colorScheme.primary;

    // FAVORİ KONTROLÜ
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final isFavorite = favoriteProvider.isFavorite(weather.cityName);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
              getLottieAssetForWeather(weather.iconCode),
              width: 90,
              height: 90,
            ),
            const SizedBox(width: 28),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          weather.cityName,
                          style: textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          isFavorite ? Icons.star : Icons.star_border,
                          color: isFavorite ? Colors.amber : Colors.grey,
                        ),
                        tooltip:
                            isFavorite
                                ? "Favorilerden kaldır"
                                : "Favorilere ekle",
                        onPressed: () {
                          if (isFavorite) {
                            favoriteProvider.removeFavorite(weather.cityName);
                          } else {
                            favoriteProvider.addFavorite(weather.cityName);
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    weather.description[0].toUpperCase() +
                        weather.description.substring(1),
                    style: textTheme.titleMedium?.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${weather.temperature.toStringAsFixed(1)}°C',
                    style: textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 20,
                    runSpacing: 8,
                    children: [
                      InfoItem(
                        icon: Icons.water_drop,
                        label: "Nem",
                        value: "${weather.humidity} %",
                        color: iconColor,
                        textTheme: textTheme,
                      ),
                      InfoItem(
                        icon: Icons.air,
                        label: "Rüzgar",
                        value: "${weather.windSpeed} m/s",
                        color: iconColor,
                        textTheme: textTheme,
                      ),
                      InfoItem(
                        icon: Icons.compress,
                        label: "Basınç",
                        value: "${weather.pressure} hPa",
                        color: iconColor,
                        textTheme: textTheme,
                      ),
                      if (weather.uvi != null)
                        InfoItem(
                          icon: Icons.sunny,
                          label: "UV",
                          value: weather.uvi!.toStringAsFixed(1),
                          color: iconColor,
                          textTheme: textTheme,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
