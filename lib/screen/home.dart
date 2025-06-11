import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../provider/weather.dart';
import '../widget/drawer.dart';
import '../widget/weather_info.dart';

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
      appBar: AppBar(
        title: const Text("Hava Durumu"),
        centerTitle: true,
        actions: [],
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: "Şehir adı",
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    final city = _cityController.text.trim();
                    if (city.isNotEmpty) {
                      weatherProvider.fetchWeather(city);
                    }
                  },
                ),
              ),
            ),
            const Gap(10),
            if (weatherProvider.isLoading) const CircularProgressIndicator(),
            if (weatherProvider.errorMessage != null)
              Text(
                weatherProvider.errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            if (weatherProvider.weather != null)
              WeatherInfo(weather: weatherProvider.weather!),
          ],
        ),
      ),
    );
  }
}
