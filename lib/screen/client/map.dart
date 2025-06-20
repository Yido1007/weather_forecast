import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class WeatherRadarScreen extends StatefulWidget {
  const WeatherRadarScreen({super.key});

  @override
  State<WeatherRadarScreen> createState() => _WeatherRadarScreenState();
}

class _WeatherRadarScreenState extends State<WeatherRadarScreen> {
  String _selectedLayer = 'clouds_new';

  final String _apiKey = dotenv.env['OPENWEATHER_API_KEY']!;

  static const LatLng defaultCenter = LatLng(41.0082, 28.9784);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> layers = [
      {'key': 'clouds_new', 'label': 'cloud'.tr()},
      {'key': 'precipitation_new', 'label': 'precipitation'.tr()},
      {'key': 'temp_new', 'label': 'temperature'.tr()},
      {'key': 'wind_new', 'label': 'wind'.tr()},
    ];

    return Scaffold(
      appBar: AppBar(title: Text('maps'.tr()), centerTitle: true),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:
                  layers.map((layer) {
                    return ChoiceChip(
                      label: Text(layer['label']!),
                      selected: _selectedLayer == layer['key'],
                      onSelected: (_) {
                        setState(() => _selectedLayer = layer['key']!);
                      },
                    );
                  }).toList(),
            ),
          ),
          Expanded(
            child: FlutterMap(
              options: MapOptions(initialCenter: defaultCenter),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: const ['a', 'b', 'c'],
                  userAgentPackageName: 'com.example.app',
                ),
                TileLayer(
                  urlTemplate:
                      'https://tile.openweathermap.org/map/$_selectedLayer/{z}/{x}/{y}.png?appid=$_apiKey',
                  userAgentPackageName: 'com.example.app',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
