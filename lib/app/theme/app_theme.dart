import 'package:careme/app/theme/text_style.dart';
import 'package:flutter/material.dart';

import 'colors.dart';
import 'widgets.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryLight,
    scaffoldBackgroundColor: AppColors.surfaceLight,
    colorScheme: ColorScheme.light(
      primary: AppColors.primaryLight,
      secondary: AppColors.secondaryLight,
      surface: AppColors.surfaceLight,
      error: AppColors.errorLight,
    ),
    fontFamily: 'Poppins',
    textTheme: AppTextStyles.lightTextTheme,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: AppWidgets.elevatedButtonStyle(),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: AppWidgets.outlineButtonStyle(),
    ),
    inputDecorationTheme: AppWidgets.inputDecoration(),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryDark,
    scaffoldBackgroundColor: AppColors.surfaceDark,
    colorScheme: ColorScheme.dark(
      primary: AppColors.primaryDark,
      secondary: AppColors.secondaryDark,
      surface: AppColors.surfaceDark,
      error: AppColors.errorDark,
    ),
    fontFamily: 'Roboto',
    textTheme: AppTextStyles.darkTextTheme,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: AppWidgets.elevatedButtonStyle(isDark: true),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: AppWidgets.outlineButtonStyle(isDark: true),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surfaceDark,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );
}
