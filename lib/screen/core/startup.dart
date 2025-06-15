import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_forecast/screen/core/boarding.dart';
import 'package:weather_forecast/screen/static/splash.dart';

class StartupRouter extends StatefulWidget {
  const StartupRouter({super.key});

  @override
  State<StartupRouter> createState() => _StartupRouterState();
}

class _StartupRouterState extends State<StartupRouter> {
  bool? _boardingShown;

  @override
  void initState() {
    super.initState();
    _checkBoarding();
  }

  Future<void> _checkBoarding() async {
    final prefs = await SharedPreferences.getInstance();
    final shown = prefs.getBool('boarding_shown') ?? false;
    setState(() => _boardingShown = shown);
  }

  @override
  Widget build(BuildContext context) {
    if (_boardingShown == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return _boardingShown! ? const SplashScreen() : const BoardingScreen();
  }
}
