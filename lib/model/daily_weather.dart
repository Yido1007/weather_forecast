class DailyWeather {
  final DateTime date;
  final double minTemp;
  final double maxTemp;
  final String icon;

  DailyWeather({
    required this.date,
    required this.minTemp,
    required this.maxTemp,
    required this.icon,
  });

  factory DailyWeather.fromJson(Map<String, dynamic> json) {
    return DailyWeather(
      date:
          DateTime.fromMillisecondsSinceEpoch(
            json['dt'] * 1000,
            isUtc: true,
          ).toLocal(),
      minTemp: json['temp']['min'].toDouble(),
      maxTemp: json['temp']['max'].toDouble(),
      icon: json['weather'][0]['icon'],
    );
  }
}
