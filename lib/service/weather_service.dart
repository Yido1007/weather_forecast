import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../model/weather.dart';

class WeatherService {
  final String _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  final String _apiKey = dotenv.env['OPENWEATHER_API_KEY']!;

  Future<Weather> fetchWeather(String city) async {
    final response = await http.get(
      Uri.parse('$_baseUrl?q=$city&units=metric&appid=$_apiKey&lang=tr'),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Weather.fromJson(json);
    } else {
      throw Exception('Hava durumu alınamadı');
    }
  }
}
