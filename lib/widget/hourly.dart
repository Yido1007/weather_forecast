import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/weather.dart';

class HourlyWeatherWidget extends StatelessWidget {
  const HourlyWeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final hourlyWeather = Provider.of<WeatherProvider>(context).hourlyWeather;

    if (hourlyWeather.isEmpty) {
      return Center(child: Text('Saatlik hava durumu yok.'));
    }

    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount:
            hourlyWeather.length > 12 ? 8 : hourlyWeather.length, // İlk 8 saat
        itemBuilder: (ctx, i) {
          final weather = hourlyWeather[i];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('${weather.dateTime.hour}:00'),
                  Image.network(
                    'https://openweathermap.org/img/wn/${weather.icon}@2x.png',
                    width: 48,
                    height: 48,
                  ),
                  Text('${weather.temperature.toStringAsFixed(1)}°C'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
