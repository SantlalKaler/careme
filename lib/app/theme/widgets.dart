import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class AppWidgets {
  static ButtonStyle elevatedButtonStyle({bool isDark = false}) {
    return ElevatedButton.styleFrom(
      backgroundColor: isDark ? AppColors.primaryDark : AppColors.primaryLight,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
    );
  }

  static ButtonStyle outlineButtonStyle({bool isDark = false}) {
    return OutlinedButton.styleFrom(
      side: BorderSide(
        color: isDark ? AppColors.primaryDark : AppColors.primaryLight,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
    );
  }

  static InputDecorationTheme inputDecoration({bool isDark = false}) {
    return InputDecorationTheme(
      filled: true,
      fillColor: Colors.transparent,
      labelStyle: GoogleFonts.poppins(
        color: Colors.grey.shade600,
        fontSize: 13,
      ),
      hintStyle: GoogleFonts.poppins(fontSize: 13),
      contentPadding: const EdgeInsets.all(15),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(15),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(15),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(15),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(15),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryLight),
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
