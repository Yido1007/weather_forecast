import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../provider/weather.dart';
import '../widget/drawer.dart';
import '../widget/weather/hourly_weather.dart';
import '../widget/weather/weather_info.dart';
import '../widget/weather/weekly_weather.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _cityController = TextEditingController();

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Hava Durumu"), centerTitle: true),
      drawer: AppDrawer(
        onCitySelected: (city) async {
          final lat = weatherProvider.weather?.lat;
          final lon = weatherProvider.weather?.lon;
          _cityController.text = city; // update search box
          await weatherProvider.fetchWeather(city);
          if (lat != null && lon != null) {
            await weatherProvider.fetchWeeklyWeather(lat, lon);
          }
          if (lat != null && lon != null) {
            await weatherProvider.fetchHourlyWeather(lat, lon);
          }
          setState(() {});
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(8),
                TextField(
                  controller: _cityController,
                  decoration: InputDecoration(
                    labelText: "Şehir adı",
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () async {
                        final city = _cityController.text.trim();
                        if (city.isNotEmpty) {
                          await weatherProvider.fetchWeather(city);
                          final lat = weatherProvider.weather?.lat;
                          final lon = weatherProvider.weather?.lon;
                          if (lat != null && lon != null) {
                            await weatherProvider.fetchHourlyWeather(lat, lon);
                            await weatherProvider.fetchWeeklyWeather(lat, lon);
                          }
                          setState(() {});
                        }
                      },
                    ),
                  ),
                ),
                const Gap(10),
                if (weatherProvider.isLoading)
                  const CircularProgressIndicator(),
                if (weatherProvider.errorMessage != null)
                  Text(
                    weatherProvider.errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                if (weatherProvider.weather != null) ...[
                  WeatherInfo(weather: weatherProvider.weather!),
                  const Gap(10),
                  SizedBox(height: 220, child: HourlyWeatherWidget()),
                  Gap(10),
                  WeeklyWeatherWidget(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
