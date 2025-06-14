import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:weather_forecast/screen/home.dart';
import 'package:weather_forecast/theme/app_colors.dart';
import 'provider/favorite.dart';
import 'provider/theme.dart';
import 'provider/weather.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => WeatherProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return MaterialApp(
      title: 'Hava Durumu',
      debugShowCheckedModeBanner: false,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: FlexThemeData.light(
        colorScheme: lightColorScheme,
        useMaterial3: true,
      ),
      darkTheme: FlexThemeData.dark(
        colorScheme: darkColorScheme,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
