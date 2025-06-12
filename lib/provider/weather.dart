import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_forecast/model/hourly_weather.dart';

import '../model/weather.dart';
import '../service/weather_service.dart';

class WeatherProvider with ChangeNotifier {
  final WeatherService _weatherService = WeatherService();

  Weather? _weather;
  List<HourlyWeather> _hourlyWeather = [];
  bool _isLoading = false;
  String? _errorMessage;

  Weather? get weather => _weather;
  List<HourlyWeather> get hourlyWeather => _hourlyWeather;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchWeather(String cityName) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _weather = await _weatherService.fetchWeather(cityName);
    } catch (e) {
      _errorMessage = "Veri alınırken bir hata oluştu: ${e.toString()}";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<WeatherData> fetchWeatherData(String cityName) async {
    // Bu, tek seferlik veriyi getirir ama provider durumunu etkilemez
    final response = await http.get(
      Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=1635f02e1038c39b416d661b002105e0&units=metric',
      ),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return WeatherData.fromJson(data);
    } else {
      throw Exception('Veri alınamadı');
    }
  }

  Future<void> fetchHourlyWeather(String city) async {
    print("Saatlik veri çekiliyor: $city");
    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=1635f02e1038c39b416d661b002105e0&units=metric&lang=tr',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> list = jsonData['list'];
      _hourlyWeather =
          list.map((item) => HourlyWeather.fromJson(item)).toList();
      notifyListeners();
    } else {
      throw Exception('Saatlik hava durumu alınamadı');
    }
  }
}
