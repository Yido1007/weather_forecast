import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_forecast/provider/favorite.dart';
import 'package:weather_forecast/provider/weather.dart';

class FavoriteLocations extends StatelessWidget {
  final Function(String) onCitySelected;
  const FavoriteLocations({super.key, required this.onCitySelected});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favori Şehirler'), centerTitle: true),
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
                      padding: EdgeInsets.symmetric(horizontal: 20),
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
                        return ListTile(
                          leading:
                              iconUrl != null
                                  ? Image.network(
                                    iconUrl,
                                    width: 40,
                                    height: 40,
                                  )
                                  : Icon(Icons.update),
                          title: Text(city),
                          subtitle:
                              temperature != null
                                  ? Text('${temperature.round()}°C')
                                  : null,
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
