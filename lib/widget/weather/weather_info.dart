import 'package:flutter/material.dart';
import '../../model/weather.dart';
import 'info_item.dart';

class WeatherInfo extends StatelessWidget {
  final Weather weather;
  const WeatherInfo({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final iconColor = Theme.of(context).colorScheme.primary;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Büyük hava durumu ikonu
            Image.network(
              'https://openweathermap.org/img/wn/${weather.iconCode}@4x.png',
              width: 90,
              height: 90,
            ),
            const SizedBox(width: 28),
            // Bilgiler
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    weather.cityName,
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
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
