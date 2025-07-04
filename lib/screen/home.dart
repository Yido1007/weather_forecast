import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../provider/weather.dart';
import '../widget/drawer/drawer.dart';
import '../widget/weather/hourly_weather.dart';
import '../widget/weather/weather_info.dart';
import '../widget/weather/weekly_weather.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final weatherProvider = Provider.of<WeatherProvider>(
        context,
        listen: false,
      );
      await weatherProvider.loadLocationPreference();
      if (!weatherProvider.useCurrentLocation) {
        final lastCity = await weatherProvider.loadLastSearchedCity();
        if (lastCity != null && lastCity.isNotEmpty) {
          _cityController.text = lastCity;
          await weatherProvider.fetchWeather(lastCity, context);
          final lat = weatherProvider.weather?.lat;
          final lon = weatherProvider.weather?.lon;
          if (lat != null && lon != null) {
            await weatherProvider.fetchHourlyWeather(lat, lon);
            await weatherProvider.fetchWeeklyWeather(lat, lon);
          }
          setState(() {});
        }
      }
    });
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  Future<void> _searchCity() async {
    final weatherProvider = Provider.of<WeatherProvider>(
      context,
      listen: false,
    );
    final city = _cityController.text.trim();
    if (city.isNotEmpty) {
      await weatherProvider.fetchWeather(city, context);
      final lat = weatherProvider.weather?.lat;
      final lon = weatherProvider.weather?.lon;
      if (lat != null && lon != null) {
        await weatherProvider.fetchHourlyWeather(lat, lon);
        await weatherProvider.fetchWeeklyWeather(lat, lon);
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('title'.tr()),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
      ),
      drawer: AppDrawer(
        onCitySelected: (city) async {
          _cityController.text = city;
          await weatherProvider.fetchWeather(city, context);
          final lat = weatherProvider.weather?.lat;
          final lon = weatherProvider.weather?.lon;
          if (lat != null && lon != null) {
            await weatherProvider.fetchHourlyWeather(lat, lon);
            await weatherProvider.fetchWeeklyWeather(lat, lon);
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
                const Gap(8),
                if (!weatherProvider.useCurrentLocation)
                  TextField(
                    autofocus: false,
                    controller: _cityController,
                    decoration: InputDecoration(
                      labelText: "city".tr(),
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: _searchCity,
                      ),
                    ),
                    onSubmitted: (_) => _searchCity(),
                  ),
                if (weatherProvider.useCurrentLocation)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(8),
                      Text(
                        weatherProvider.currentLocationName ??
                            "Konum alınıyor...",
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const Gap(6),
                    ],
                  ),
                const Gap(10),
                if (weatherProvider.isLoading)
                  const Center(child: CircularProgressIndicator()),
                if (weatherProvider.errorMessage != null)
                  Text(
                    weatherProvider.errorMessage!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                if (weatherProvider.weather != null) ...[
                  WeatherInfo(weather: weatherProvider.weather!),
                  const Gap(10),
                  SizedBox(height: 220, child: HourlyWeatherWidget()),
                  const Gap(10),
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
