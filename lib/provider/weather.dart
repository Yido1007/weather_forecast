import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_forecast/model/hourly_weather.dart';
import 'package:weather_forecast/service/location.dart';
import 'package:weather_forecast/service/notification.dart';

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
  bool _useCurrentLocation = false;
  bool get useCurrentLocation => _useCurrentLocation;

  String? _currentLocationName;
  String? get currentLocationName => _currentLocationName;

  Weather? get weather => _weather;
  List<HourlyWeather> get hourlyWeather => _hourlyWeather;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

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
        checkSevereWeather(_weather!);
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

  Future<String?> getCityNameFromCoordinates(double lat, double lon) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);
    if (placemarks.isNotEmpty) {
      return placemarks.first.locality;
    }
    return null;
  }

  Future<void> fetchWeatherByLocation(
    double lat,
    double lon,
    String lang,
  ) async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$_apiKey&units=metric&lang=$lang',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        _weather = Weather.fromJson(jsonData);
        _isLoading = false;
        notifyListeners();
      } else {
        _isLoading = false;
        _errorMessage = "Veri alınamadı: ${response.statusCode}";
        notifyListeners();
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = "Hata: $e";
      notifyListeners();
    }
  }

  Future<void> loadLocationPreference() async {
    final prefs = await SharedPreferences.getInstance();
    _useCurrentLocation = prefs.getBool('use_current_location') ?? false;
    notifyListeners();
    // Eğer açık ise konumdan veri çek
    if (_useCurrentLocation) {
      await setUseCurrentLocation(true, fromStartup: true);
    }
  }

  Future<void> setUseCurrentLocation(
    bool value, {
    bool fromStartup = false,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    _useCurrentLocation = value;
    await prefs.setBool('use_current_location', value);
    notifyListeners();
    if (value) {
      final pos = await getCurrentLocation();
      if (pos != null) {
        _currentLocationName = await getCityNameFromCoordinates(
          pos.latitude,
          pos.longitude,
        );
        await fetchWeatherByLocation(pos.latitude, pos.longitude, "tr");
        await fetchHourlyWeather(pos.latitude, pos.longitude);
        await fetchWeeklyWeather(pos.latitude, pos.longitude);
      } else {
        _currentLocationName = "Konum alınamadı";
      }
      notifyListeners();
    } else if (!fromStartup) {}
  }

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

  void checkSevereWeather(Weather weather) {
    if (!(Platform.isAndroid || Platform.isIOS)) return;

    if (weather.temperature > 38) {
      showWeatherNotification(
        "Aşırı Sıcaklık Uyarısı",
        "${weather.cityName} için sıcaklık ${weather.temperature.toStringAsFixed(1)}°C'nin üzerinde!",
      );
    }
    if (weather.temperature < 0) {
      showWeatherNotification(
        "Aşırı Soğuk Uyarısı",
        "${weather.cityName} için sıcaklık 0°C'nin altında!",
      );
    }
    if (weather.windSpeed > 15) {
      showWeatherNotification(
        "Fırtına Uyarısı",
        "${weather.cityName} için rüzgar hızı çok yüksek (${weather.windSpeed} m/s)!",
      );
    }
    if (weather.description.contains("fırtına") ||
        weather.description.toLowerCase().contains("storm")) {
      showWeatherNotification(
        "Fırtına Uyarısı",
        "${weather.cityName} için fırtına bekleniyor!",
      );
    }
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
      '$_oneCall/onecall?lat=$lat&lon=$lon&appid=$_apiKey&units=metric',
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
