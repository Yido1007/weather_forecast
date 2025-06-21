import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_forecast/provider/units/temperature.dart';
import 'package:weather_forecast/service/units/temperature.dart';

import '../../provider/weather.dart';
import '../../service/lottie_func.dart';

class WeeklyWeatherWidget extends StatelessWidget {
  const WeeklyWeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final weeklyWeather = Provider.of<WeatherProvider>(context).weeklyWeather;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final unitProvider = Provider.of<TemperatureUnitProvider>(context);
    final unit = unitProvider.unit;
    final unitText = unitSymbol(unit);

    if (weeklyWeather.isEmpty) {
      return Text(
        'Haftalık hava durumu verisi yok.',
        style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface),
      );
    }
    return Card(
      color: colorScheme.surface,
      margin: const EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(
              "weekly".tr(),
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
            const Divider(thickness: 1),
            ...weeklyWeather.map((day) {
              // GÜNLÜK SICAKLIKLARI BİRİME ÇEVİR
              final maxTemp = convertTemperature(day.maxTemp, unit);
              final minTemp = convertTemperature(day.minTemp, unit);
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 95,
                      child: Text(
                        DateFormat.EEEE(
                          context.locale.languageCode,
                        ).format(day.date),
                        style: textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ),
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer.withOpacity(0.92),
                        shape: BoxShape.circle,
                      ),
                      child: Lottie.asset(
                        getLottieAssetForWeather(day.icon),
                        fit: BoxFit.contain,
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "↑ ${maxTemp.toStringAsFixed(1)}$unitText",
                            style: textTheme.bodyMedium?.copyWith(
                              color: colorScheme.error,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Gap(16),
                          Text(
                            "↓ ${minTemp.toStringAsFixed(1)}$unitText",
                            style: textTheme.bodyMedium?.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
