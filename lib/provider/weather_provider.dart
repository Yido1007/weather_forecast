import 'package:flutter/material.dart';

import '../model/weather.dart';
import '../service/weather_service.dart';


class WeatherProvider with ChangeNotifier {
  final WeatherService _weatherService = WeatherService();

  Weather? _weather;
  bool _isLoading = false;
  String? _errorMessage;

  Weather? get weather => _weather;
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
}
