import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = true;
  double _fontSize = 14.0;
  double _iconSize = 58.0;
  String _themeColor = 'Turquoise';
  String _pin = '1234';
  Color _primaryColor = const Color(0xFF00BCD4);

  bool get isDarkMode => _isDarkMode;
  double get fontSize => _fontSize;
  double get iconSize => _iconSize;
  String get themeColor => _themeColor;
  String get pin => _pin;
  Color get primaryColor => _primaryColor;

  ThemeProvider() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _isDarkMode = prefs.getBool('dark_mode') ?? true;
      _fontSize = prefs.getDouble('font_size') ?? 14.0;
      _iconSize = prefs.getDouble('icon_size') ?? 58.0;
      _pin = prefs.getString('user_pin') ?? '1234';
      _themeColor = prefs.getString('theme_color') ?? 'Turquoise';
      final colorHex = prefs.getString('primary_color');
      if (colorHex != null) _primaryColor = Color(int.parse(colorHex));
    } catch (_) {}
    notifyListeners();
  }

  Future<void> _saveSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('dark_mode', _isDarkMode);
      await prefs.setDouble('font_size', _fontSize);
      await prefs.setDouble('icon_size', _iconSize);
      await prefs.setString('user_pin', _pin);
      await prefs.setString('theme_color', _themeColor);
      await prefs.setString('primary_color', _primaryColor.value.toString());
    } catch (_) {}
  }

  void toggleTheme() { _isDarkMode = !_isDarkMode; _saveSettings(); notifyListeners(); }
  void setFontSize(double size) { _fontSize = size.clamp(10.0, 24.0); _saveSettings(); notifyListeners(); }
  void setIconSize(double size) { _iconSize = size.clamp(48.0, 78.0); _saveSettings(); notifyListeners(); }
  void setThemeColor(String color) { _themeColor = color; _saveSettings(); notifyListeners(); }
  void setPin(String newPin) { _pin = newPin; _saveSettings(); notifyListeners(); }

  ThemeData getThemeData() {
    return ThemeData(
      brightness: _isDarkMode ? Brightness.dark : Brightness.light,
      primaryColor: _primaryColor,
      scaffoldBackgroundColor: _isDarkMode ? Colors.black : Colors.grey[50],
      appBarTheme: AppBarTheme(
        backgroundColor: _isDarkMode ? Colors.black : Colors.white,
        foregroundColor: _primaryColor,
        elevation: 0,
      ),
      iconTheme: IconThemeData(color: _primaryColor, size: 24 * (_iconSize / 58)),
    );
  }
}
