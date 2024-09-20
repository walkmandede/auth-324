import 'package:flutter/material.dart';
import 'm_theme_model.dart';

class DarkThemeData {
  static ThemeModel theme = ThemeModel(
      primary: const Color(0xFF2fb676),
      primarySoft: const Color(0xFF164940),
      primaryAccent: const Color(0xFFffffff),
      background1: const Color(0xFF0B1C28),
      text1: const Color(0xFFFFFFFF),
      text2: const Color(0xFF858d93),
      disableColor: Colors.grey,
      secondaryAccent: const Color(0xff0e292e), // Deep navy blue for accent, inverted from light theme
      primaryOver:
          Colors.black, // Black for text or icons over the primary color
      background2: const Color(0xFF121212),
      greenSuccess: const Color(
          0xFF66BB6A), // Slightly lighter green for success messages, still distinct
      redDanger:
          const Color(0xFFEF5350), // Softer red for danger or error messages
      yellowWarning: const Color(
          0xFFFDD835), // Bright yellow for warnings, stands out against dark backgrounds
      bgGradient1: const LinearGradient(
        colors: [
          Color(0xFF121212), // Very dark grey
          Color(0xFF1E1E1E), // Slightly lighter grey
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderGray: const Color.fromARGB(255, 234, 234, 234),
      icon: const Color.fromARGB(255, 233, 233, 233),
      userIcon: const Color(0xff31D988),
      mgmtIcon: const Color(0xff4F95FF));
}
