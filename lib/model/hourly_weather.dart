// weather_hourly.dart
class HourlyWeather {
  final DateTime dateTime;
  final double temperature;
  final String icon;

  HourlyWeather({
    required this.dateTime,
    required this.temperature,
    required this.icon,
  });

  factory HourlyWeather.fromJson(Map<String, dynamic> json) {
    return HourlyWeather(
      dateTime:
          DateTime.fromMillisecondsSinceEpoch(
            json['dt'] * 1000,
            isUtc: true,
          ).toLocal(),
      temperature: json['main']['temp'].toDouble(), // Doğru!
      icon: json['weather'][0]['icon'],
    );
  }
}
