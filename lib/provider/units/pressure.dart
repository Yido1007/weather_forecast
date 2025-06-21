import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum PressureUnit { hpa, mmhg, atm, psi }

class PressureUnitProvider extends ChangeNotifier {
  PressureUnit _pressureUnit = PressureUnit.hpa;

  PressureUnit get pressureUnit => _pressureUnit;

  PressureUnitProvider() {
    _loadUnit();
  }

  Future<void> _loadUnit() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString('pressure_unit') ?? 'hpa';
    _pressureUnit = PressureUnit.values.firstWhere(
      (e) => e.name == value,
      orElse: () => PressureUnit.hpa,
    );
    notifyListeners();
  }

  Future<void> setPressureUnit(PressureUnit unit) async {
    _pressureUnit = unit;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('pressure_unit', unit.name);
  }
}
