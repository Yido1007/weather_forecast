class Weather {
  final String description;
  final String iconCode;
  final double temperature;
  final String cityName;
  final double lat;
  final double lon;
  final int humidity;
  final double windSpeed;
  final int pressure;
  final double? uvi; // optional, OneCall'da var

  Weather({
    required this.description,
    required this.iconCode,
    required this.temperature,
    required this.cityName,
    required this.lat,
    required this.lon,
    required this.humidity,
    required this.windSpeed,
    required this.pressure,
    this.uvi,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      description: json['weather'][0]['description'],
      iconCode: json['weather'][0]['icon'],
      temperature: json['main']['temp'].toDouble(),
      cityName: json['name'],
      lat: json['coord']['lat'].toDouble(),
      lon: json['coord']['lon'].toDouble(),
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'].toDouble(),
      pressure: json['main']['pressure'],
      uvi: json['uvi'] != null ? (json['uvi'] as num).toDouble() : null,
    );
  }
}

class WeatherData {
  final String cityName;
  final double temperature;
  final String iconCode;

  WeatherData({
    required this.cityName,
    required this.temperature,
    required this.iconCode,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      iconCode: json['weather'][0]['icon'],
    );
  }

  String get iconUrl => 'https://openweathermap.org/img/wn/$iconCode@2x.png';
}
