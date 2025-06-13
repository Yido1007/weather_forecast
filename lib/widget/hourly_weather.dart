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

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Column(
          children: [
            const Text(
              "Saatlik Hava Durumu Tahmini",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const Divider(thickness: 1),

            SizedBox(
              height: 110,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: hourlyWeather.length > 8 ? 8 : hourlyWeather.length,
                itemBuilder: (ctx, i) {
                  final weather = hourlyWeather[i];
                  return Container(
                    width: 80,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${weather.dateTime.hour}:00',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Image.network(
                          'https://openweathermap.org/img/wn/${weather.icon}@2x.png',
                          width: 40,
                          height: 40,
                        ),
                        Text(
                          '${weather.temperature.toStringAsFixed(1)}°C',
                          style: const TextStyle(fontWeight: FontWeight.bold),
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
