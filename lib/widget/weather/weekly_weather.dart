import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../../provider/weather.dart';

class WeeklyWeatherWidget extends StatelessWidget {
  const WeeklyWeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final weeklyWeather = Provider.of<WeatherProvider>(context).weeklyWeather;

    if (weeklyWeather.isEmpty) {
      return const Text('Haftalık hava durumu verisi yok.');
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const Text(
              "7 Günlük Hava Tahmini",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const Divider(thickness: 1),
            ...weeklyWeather.map((day) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 95,
                      child: Text(
                        "${["Pazar", "Pazartesi", "Salı", "Çarşamba", "Perşembe", "Cuma", "Cumartesi"][day.date.weekday % 7]}",
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    Image.network(
                      'https://openweathermap.org/img/wn/${day.icon}@2x.png',
                      width: 36,
                      height: 36,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "↑ ${day.maxTemp.toStringAsFixed(1)}°",
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Gap(16),
                          Text(
                            "↓ ${day.minTemp.toStringAsFixed(1)}°",
                            style: const TextStyle(
                              color: Colors.blue,
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
