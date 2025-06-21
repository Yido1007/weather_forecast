import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum WindSpeedUnit { kmh, ms, mph }

class WindSpeedUnitProvider extends ChangeNotifier {
  WindSpeedUnit _windSpeedUnit = WindSpeedUnit.kmh;

  WindSpeedUnit get windSpeedUnit => _windSpeedUnit;

  WindSpeedUnitProvider() {
    _loadUnit();
  }

  Future<void> _loadUnit() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString('wind_speed_unit') ?? 'kmh';
    _windSpeedUnit = WindSpeedUnit.values.firstWhere(
      (e) => e.name == value,
      orElse: () => WindSpeedUnit.kmh,
    );
    notifyListeners();
  }

  Future<void> setWindSpeedUnit(WindSpeedUnit unit) async {
    _windSpeedUnit = unit;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('wind_speed_unit', unit.name);
  }
}
