import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_forecast/model/hourly_weather.dart';

import '../model/daily_weather.dart';
import '../model/weather.dart';

class WeatherProvider with ChangeNotifier {
  final String _apiKey = dotenv.env['OPENWEATHER_API_KEY']!;
  final String _baseUrl = 'https://api.openweathermap.org/data/2.5';
  final String _oneCall = 'https://api.openweathermap.org/data/3.0';

  List<DailyWeather> _weeklyWeather = [];
  List<DailyWeather> get weeklyWeather => _weeklyWeather;
  Weather? _weather;
  List<HourlyWeather> _hourlyWeather = [];
  bool _isLoading = false;
  String? _errorMessage;
  String? _lastSearchedCity;
  String? get lastSearchedCity => _lastSearchedCity;

  Weather? get weather => _weather;
  List<HourlyWeather> get hourlyWeather => _hourlyWeather;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> saveLastSearchedCity(String city) async {
    _lastSearchedCity = city;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('last_city', city);
  }

  Future<String?> loadLastSearchedCity() async {
    final prefs = await SharedPreferences.getInstance();
    _lastSearchedCity = prefs.getString('last_city');
    return _lastSearchedCity;
  }

  Future<void> fetchWeather(String city, BuildContext context) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final lang = context.locale.languageCode;

    try {
      final url = Uri.parse(
        '$_baseUrl/weather?q=$city&appid=$_apiKey&units=metric&lang=$lang',
      );
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        _weather = Weather.fromJson(jsonData);
        _isLoading = false;
      } else {
        _weather = null;
        _errorMessage = 'Veri alınamadı (${response.statusCode})';
        _isLoading = false;
      }
    } catch (e) {
      _weather = null;
      _errorMessage = 'Bir hata oluştu: $e';
      _isLoading = false;
    }
    notifyListeners();
  }

  Future<WeatherData> fetchWeatherData(String cityName) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/weather?q=$cityName&appid=$_apiKey&units=metric'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return WeatherData.fromJson(data);
    } else {
      throw Exception('Veri alınamadı');
    }
  }

  Future<void> fetchHourlyWeather(double lat, double lon) async {
    final url = Uri.parse(
      'https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&exclude=current,minutely,daily,alerts&appid=$_apiKey&units=metric&lang=tr',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> list = jsonData['hourly'];
      _hourlyWeather =
          list.map((item) => HourlyWeather.fromJson(item)).toList();

      notifyListeners();
    } else {
      throw Exception('Saatlik hava durumu alınamadı');
    }
  }

  Future<void> fetchWeeklyWeather(double lat, double lon) async {
    final url = Uri.parse(
      '$_oneCall/onecall?lat=41.0082&lon=28.9784&appid=$_apiKey&units=metric',
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> list = jsonData['daily'];
      _weeklyWeather = list.map((item) => DailyWeather.fromJson(item)).toList();
      notifyListeners();
    } else {
      throw Exception('Haftalık hava durumu alınamadı');
    }
  }
}
