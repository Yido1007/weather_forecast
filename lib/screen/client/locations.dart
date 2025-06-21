import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_forecast/provider/favorite.dart';
import 'package:weather_forecast/provider/temperature.dart';
import 'package:weather_forecast/provider/weather.dart';
import 'package:weather_forecast/service/temperature.dart';

class FavoriteLocations extends StatelessWidget {
  final Function(String) onCitySelected;
  const FavoriteLocations({super.key, required this.onCitySelected});

  @override
  Widget build(BuildContext context) {

    final unitProvider = Provider.of<TemperatureUnitProvider>(context);
    final unit = unitProvider.unit;
    final unitText = unitSymbol(unit);

    return Scaffold(
      appBar: AppBar(title: Text('fav-location').tr(), centerTitle: true),
      body: Consumer<FavoriteProvider>(
        builder: (context, favoriteProvider, _) {
          final favorites = favoriteProvider.favorites;
          if (favorites.isEmpty) {
            return Center(child: Text('Favori şehir yok.'));
          }
          return ListView(
            children:
                favorites.map((city) {
                  return Dismissible(
                    key: Key(city),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Theme.of(context).colorScheme.error,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Icon(
                        Icons.delete,
                        color: Theme.of(context).colorScheme.onError,
                      ),
                    ),
                    onDismissed: (_) => favoriteProvider.removeFavorite(city),
                    child: FutureBuilder(
                      future: Provider.of<WeatherProvider>(
                        context,
                        listen: false,
                      ).fetchWeatherData(city),
                      builder: (context, snapshot) {
                        String? iconUrl;
                        double? temperature;
                        if (snapshot.hasData) {
                          final weather = snapshot.data!;
                          iconUrl = weather.iconUrl;
                          temperature = weather.temperature;
                        }
                        String? tempText;
                        if (temperature != null) {
                          final convertedTemp = convertTemperature(
                            temperature,
                            unit,
                          );
                          tempText = '${convertedTemp.round()}$unitText';
                        }

                        return ListTile(
                          leading:
                              iconUrl != null
                                  ? Image.network(
                                    iconUrl,
                                    width: 40,
                                    height: 40,
                                  )
                                  : const Icon(Icons.update),
                          title: Text(city),
                          subtitle: tempText != null ? Text(tempText) : null,
                          onTap: () => onCitySelected(city),
                        );
                      },
                    ),
                  );
                }).toList(),
          );
        },
      ),
    );
  }
}
