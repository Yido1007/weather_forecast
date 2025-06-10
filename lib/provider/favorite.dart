import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteProvider with ChangeNotifier {
  List<String> _favorites = [];

  List<String> get favorites => _favorites;

  FavoriteProvider() {
    _loadFavorites();
  }

  void _loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _favorites = prefs.getStringList('favoriteCities') ?? [];
    notifyListeners();
  }

  void _saveFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favoriteCities', _favorites);
  }

  void addFavorite(String city) {
    if (!_favorites.contains(city)) {
      _favorites.add(city);
      _saveFavorites();
      notifyListeners();
    }
  }

  void removeFavorite(String city) {
    if (_favorites.contains(city)) {
      _favorites.remove(city);
      _saveFavorites();
      notifyListeners();
    }
  }

  bool isFavorite(String city) {
    return _favorites.contains(city);
  }
}
