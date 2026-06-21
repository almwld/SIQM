import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF1A237E);
  static const Color goldColor = Color(0xFFFFD700);
  static const Color darkGoldColor = Color(0xFFB8860B);
  static const Color backgroundColor = Color(0xFF0A0E27);
  static const Color textColor = Color(0xFFFFECB3);

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: goldColor,
      titleTextStyle: TextStyle(color: goldColor, fontFamily: 'Amiri', fontSize: 20),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: textColor, fontFamily: 'Amiri'),
      bodyMedium: TextStyle(color: textColor, fontFamily: 'Amiri'),
    ),
  );

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: const Color(0xFFF5F0E8),
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: goldColor,
      titleTextStyle: TextStyle(color: goldColor, fontFamily: 'Amiri', fontSize: 20),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFF2C1810), fontFamily: 'Amiri'),
      bodyMedium: TextStyle(color: Color(0xFF2C1810), fontFamily: 'Amiri'),
    ),
  );
}
