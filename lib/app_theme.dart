import 'package:flutter/material.dart';
import 'app_constants.dart';

class AppTheme {
  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.primaryBackground,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.secondaryBackground,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: AppColors.primaryText,
          fontSize: AppFontSizes.xl,
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: AppColors.primaryText,
          fontSize: AppFontSizes.huge,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: TextStyle(
          color: AppColors.primaryText,
          fontSize: AppFontSizes.xxxl,
          fontWeight: FontWeight.bold,
        ),
        displaySmall: TextStyle(
          color: AppColors.primaryText,
          fontSize: AppFontSizes.xxl,
          fontWeight: FontWeight.bold,
        ),
        headlineSmall: TextStyle(
          color: AppColors.primaryText,
          fontSize: AppFontSizes.xl,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: TextStyle(
          color: AppColors.primaryText,
          fontSize: AppFontSizes.lg,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(
          color: AppColors.primaryText,
          fontSize: AppFontSizes.base,
        ),
        bodyMedium: TextStyle(
          color: AppColors.secondaryText,
          fontSize: AppFontSizes.base,
        ),
        bodySmall: TextStyle(
          color: AppColors.tertiaryText,
          fontSize: AppFontSizes.sm,
        ),
      ),
      colorScheme: const ColorScheme.dark(
        primary: AppColors.accentPrimary,
        secondary: AppColors.accentSecondary,
        error: AppColors.errorRed,
        surface: AppColors.secondaryBackground,
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: AppColors.accentPrimary,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.medium),
        ),
      ),
    );
  }
}