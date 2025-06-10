import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.lightBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.lightAppBar,
      foregroundColor: AppColors.lightText,
    ),
    cardColor: AppColors.lightCard,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.lightText),
      bodyMedium: TextStyle(color: AppColors.lightText),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(AppColors.primary),
      trackColor: MaterialStateProperty.all(AppColors.primary.withOpacity(0.5)),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.darkBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkAppBar,
      foregroundColor: AppColors.darkText,
    ),
    cardColor: AppColors.darkCard,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.darkText),
      bodyMedium: TextStyle(color: AppColors.darkText),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(AppColors.accent),
      trackColor: MaterialStateProperty.all(AppColors.accent.withOpacity(0.4)),
    ),
  );
}
