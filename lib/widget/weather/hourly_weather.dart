import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weather_forecast/service/lottie_func.dart';
import '../../provider/weather.dart';

class HourlyWeatherWidget extends StatelessWidget {
  const HourlyWeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final hourlyWeather = Provider.of<WeatherProvider>(context).hourlyWeather;

    if (hourlyWeather.isEmpty) {
      return Center(
        child: Text(
          'Saatlik hava durumu yok.',
          style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface),
        ),
      );
    }
    final List filteredHourly = [];
    for (int i = 0; i < hourlyWeather.length; i += 2) {
      filteredHourly.add(hourlyWeather[i]);
    }

    return Card(
      color: colorScheme.surface,
      margin: const EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Column(
          children: [
            Text(
              "hourly".tr(),
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
            const Divider(thickness: 1),
            SizedBox(
              height: 110,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount:
                    filteredHourly.length > 12 ? 12 : filteredHourly.length,
                itemBuilder: (ctx, i) {
                  final weather = filteredHourly[i];
                  return Container(
                    width: 80,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${weather.dateTime.hour}:00',
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: colorScheme.primaryContainer,
                            shape: BoxShape.circle,
                          ),
                          child: Lottie.asset(
                            getLottieAssetForWeather(weather.icon),
                            fit: BoxFit.contain,
                          ),
                        ),

                        Text(
                          '${weather.temperature.toStringAsFixed(1)}°C',
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
