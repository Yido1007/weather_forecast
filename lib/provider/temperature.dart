import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum TemperatureUnit { celsius, fahrenheit, kelvin }

class TemperatureUnitProvider extends ChangeNotifier {
  TemperatureUnit _unit = TemperatureUnit.celsius;

  TemperatureUnit get unit => _unit;

  TemperatureUnitProvider() {
    _loadUnit();
  }

  Future<void> _loadUnit() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString('temperature_unit') ?? 'celsius';
    _unit = TemperatureUnit.values.firstWhere(
      (e) => e.name == value,
      orElse: () => TemperatureUnit.celsius,
    );
    notifyListeners();
  }

  Future<void> setUnit(TemperatureUnit unit) async {
    _unit = unit;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('temperature_unit', unit.name);
  }
}
