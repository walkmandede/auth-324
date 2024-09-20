import 'package:flutter/material.dart';
import 'm_theme_model.dart';

class LightThemeData {
  static ThemeModel theme = ThemeModel(
      primary: const Color(0xFF0F2943), // Deep navy blue to match the logo
      primarySoft: const Color(0xFF2D3E50), // Softer, slightly lighter blue
      primaryAccent:
          const Color(0xFFD4AF37), // Gold/Beige accent color from the logo
      primaryOver:
          Colors.white, // Color for text or icons over the primary color
      background2: const Color(
          0xFFF9F9F9), // Very light grey, almost white for a clean background
      background1:
          const Color(0xFFEDEDED), // Slightly darker grey for subtle contrast
      text1: const Color(0xFF0F2943), // Dark navy blue for primary text color
      text2: const Color(0xFF5C6C7B), // Muted grey-blue for secondary text
      disableColor: const Color(0xFFB0B0B0), // Light grey for disabled elements
      secondaryAccent: const Color(
          0xFFD4AF37), // Repeated gold/Beige accent for secondary elements
      greenSuccess: const Color(0xFF43A047), // Green for success messages
      redDanger: const Color(
          0xFFEB5757), // Slightly muted red for danger or error messages
      yellowWarning: const Color(
          0xFFF2C94C), // Soft yellow for warnings, complementary to gold
      bgGradient1: const LinearGradient(
        colors: [
          Color(0xFFF9F9F9), // Light grey
          Color(0xFFEDEDED), // Slightly darker grey
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderGray: const Color.fromARGB(255, 151, 151, 151),
      icon: const Color.fromARGB(255, 119, 119, 119),
      userIcon: const Color(0xff31D988),
      mgmtIcon: const Color(0xff4F95FF));
}
