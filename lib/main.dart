import 'package:easy_localization/easy_localization.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'package:weather_forecast/screen/core/boarding.dart';
import 'package:weather_forecast/screen/core/startup.dart';
import 'package:weather_forecast/screen/home.dart';
import 'package:weather_forecast/screen/static/splash.dart';
import 'package:weather_forecast/theme/app_colors.dart';
import 'provider/favorite.dart';
import 'provider/theme.dart';
import 'provider/weather.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('tr'), Locale('en')],
      path: 'assets/lang',
      fallbackLocale: const Locale('tr'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider(create: (_) => WeatherProvider()),
          ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        ],
        child: MyApp(), // DİKKAT: const YOK!
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        final isDarkMode = themeProvider.isDarkMode;
        return MaterialApp(
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
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          home: const StartupRouter(),
          routes: {
            '/home': (_) => HomeScreen(),
            '/splash': (_) => const SplashScreen(),
            '/boarding': (_) => const BoardingScreen(),
          },
        );
      },
    );
  }
}
