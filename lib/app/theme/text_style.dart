import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class AppTextStyles {
  // Light Theme
  static final TextTheme lightTextTheme = TextTheme(
    displayLarge: GoogleFonts.poppins(
      fontSize: 57,
      fontWeight: FontWeight.bold,
      color: AppColors.contentPrimaryLight,
    ),
    displayMedium: GoogleFonts.poppins(
      fontSize: 45,
      fontWeight: FontWeight.bold,
      color: AppColors.contentPrimaryLight,
    ),
    displaySmall: GoogleFonts.poppins(
      fontSize: 36,
      fontWeight: FontWeight.bold,
      color: AppColors.contentPrimaryLight,
    ),
    headlineLarge: GoogleFonts.poppins(
      fontSize: 32,
      fontWeight: FontWeight.w600,
      color: AppColors.contentPrimaryLight,
    ),
    headlineMedium: GoogleFonts.poppins(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: AppColors.contentPrimaryLight,
    ),
    headlineSmall: GoogleFonts.poppins(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: AppColors.contentPrimaryLight,
    ),
    titleLarge: GoogleFonts.poppins(
      fontSize: 22,
      fontWeight: FontWeight.w500,
      color: AppColors.contentPrimaryLight,
    ),
    titleMedium: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColors.contentPrimaryLight,
    ),
    titleSmall: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.contentPrimaryLight,
    ),
    bodyLarge: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: AppColors.contentSecondaryLight,
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: AppColors.contentSecondaryLight,
    ),
    bodySmall: GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: AppColors.contentTertiaryLight,
    ),
    labelLarge: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.contentPrimaryLight,
    ),
    labelMedium: GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColors.contentPrimaryLight,
    ),
    labelSmall: GoogleFonts.poppins(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      color: AppColors.contentPrimaryLight,
    ),
  );

  // Dark Theme
  static final TextTheme darkTextTheme = TextTheme(
    displayLarge: GoogleFonts.poppins(
      fontSize: 57,
      fontWeight: FontWeight.bold,
      color: AppColors.contentPrimaryDark,
    ),
    displayMedium: GoogleFonts.poppins(
      fontSize: 45,
      fontWeight: FontWeight.bold,
      color: AppColors.contentPrimaryDark,
    ),
    displaySmall: GoogleFonts.poppins(
      fontSize: 36,
      fontWeight: FontWeight.bold,
      color: AppColors.contentPrimaryDark,
    ),
    headlineLarge: GoogleFonts.poppins(
      fontSize: 32,
      fontWeight: FontWeight.w600,
      color: AppColors.contentPrimaryDark,
    ),
    headlineMedium: GoogleFonts.poppins(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: AppColors.contentPrimaryDark,
    ),
    headlineSmall: GoogleFonts.poppins(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: AppColors.contentPrimaryDark,
    ),
    titleLarge: GoogleFonts.poppins(
      fontSize: 22,
      fontWeight: FontWeight.w500,
      color: AppColors.contentPrimaryDark,
    ),
    titleMedium: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColors.contentPrimaryDark,
    ),
    titleSmall: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.contentPrimaryDark,
    ),
    bodyLarge: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: AppColors.contentSecondaryDark,
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: AppColors.contentSecondaryDark,
    ),
    bodySmall: GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: AppColors.contentTertiaryDark,
    ),
    labelLarge: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.contentPrimaryDark,
    ),
    labelMedium: GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColors.contentPrimaryDark,
    ),
    labelSmall: GoogleFonts.poppins(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      color: AppColors.contentPrimaryDark,
    ),
  );
}
