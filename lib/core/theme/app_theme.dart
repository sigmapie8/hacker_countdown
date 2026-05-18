import 'package:flutter/material.dart';

class AppColors {
  static const background = Color(0xFF000000);
  static const neonGreen = Color(0xFF00FF41);
  static const dimGreen = Color(0xFF008F11);
  static const darkGreen = Color(0xFF003B00);
}

class AppTextStyles {
  static const fontFamily = 'CourierPrime';

  static const timerDisplay = TextStyle(
    fontFamily: fontFamily,
    fontSize: 64,
    fontWeight: FontWeight.bold,
    color: AppColors.neonGreen,
    letterSpacing: 6,
    shadows: [
      Shadow(blurRadius: 10, color: AppColors.neonGreen),
      Shadow(blurRadius: 20, color: AppColors.neonGreen),
    ],
  );

  static const label = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    color: AppColors.dimGreen,
    letterSpacing: 2,
  );

  static const buttonText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    color: AppColors.neonGreen,
    letterSpacing: 3,
  );

  static const headerText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    color: AppColors.dimGreen,
    letterSpacing: 4,
  );
}

ThemeData buildAppTheme() => ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: AppTextStyles.fontFamily,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.neonGreen,
        surface: AppColors.background,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          color: AppColors.neonGreen,
          fontFamily: AppTextStyles.fontFamily,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.neonGreen),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.neonGreen, width: 2),
        ),
        labelStyle: AppTextStyles.label,
        hintStyle: AppTextStyles.label,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: AppColors.neonGreen,
          side: const BorderSide(color: AppColors.neonGreen),
          textStyle: AppTextStyles.buttonText,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.neonGreen,
        elevation: 0,
        titleTextStyle: AppTextStyles.label,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.darkGreen,
        contentTextStyle: AppTextStyles.buttonText,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      ),
    );
