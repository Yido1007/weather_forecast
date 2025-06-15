import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
    final colorScheme = Theme.of(context).colorScheme;
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final isFavorite = favoriteProvider.isFavorite(weather.cityName);

    return Card(
      color: colorScheme.surface,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              child: Lottie.asset(
                getLottieAssetForWeather(weather.iconCode),
                width: 100,
                height: 100,
              ),
            ),
            const Gap(28),
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
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          isFavorite ? Icons.star : Icons.star_border,
                          color:
                              isFavorite
                                  ? colorScheme.surfaceTint
                                  : colorScheme.outline,
                        ),
                        tooltip: isFavorite ? "unfav".tr() : "fav".tr(),
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
                  const Gap(5),
                  Text(
                    weather.description[0].toUpperCase() +
                        weather.description.substring(1),
                    style: textTheme.titleMedium?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const Gap(8),
                  Text(
                    '${weather.temperature.toStringAsFixed(1)}°C',
                    style: textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                  const Gap(12),
                  Wrap(
                    spacing: 20,
                    runSpacing: 8,
                    children: [
                      InfoItem(
                        icon: Icons.water_drop,
                        label: "humidity".tr(),
                        value: "${weather.humidity} %",
                        color: colorScheme.secondary,
                        textTheme: textTheme,
                      ),
                      InfoItem(
                        icon: Icons.air,
                        label: "wind".tr(),
                        value: "${weather.windSpeed} m/s",
                        color: colorScheme.secondary,
                        textTheme: textTheme,
                      ),
                      InfoItem(
                        icon: Icons.compress,
                        label: "pressure".tr(),
                        value: "${weather.pressure} hPa",
                        color: colorScheme.secondary,
                        textTheme: textTheme,
                      ),
                      if (weather.uvi != null)
                        InfoItem(
                          icon: Icons.sunny,
                          label: "UV",
                          value: weather.uvi!.toStringAsFixed(1),
                          color: colorScheme.secondary,
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
