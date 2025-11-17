import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyThemeModel extends ChangeNotifier {
  Color _themeColor = Colors.green;
  bool _themeMode = true; //true是白天，false是黑夜
  bool _loaded = false;
  bool _useDynamicColor = false;
  bool _useMaterial3 = true;
  bool _isImageTheme = false;

  Color get themeColor => _themeColor;
  bool get themeMode => _themeMode;
  bool get useDynamicColor => _useDynamicColor;
  bool get useMaterial3 => _useMaterial3;
  bool get isImageTheme => _isImageTheme;

  MyThemeModel () {
    _loadFromPrefs();
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _themeColor = Color(prefs.getInt("themeColor") ?? 0xFF4CAF50);
    _themeMode = prefs.getBool("themeMode") ?? true;
    _useDynamicColor = prefs.getBool("useDynamicColor") ?? false;
    _useMaterial3 = prefs.getBool("useMaterial3") ?? true;
    _isImageTheme = prefs.getBool("isImageTheme") ?? false;
    _loaded = true;
    notifyListeners();
  }

  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("themeColor", _themeColor.toARGB32());
    await prefs.setBool("themeMode", _themeMode);
    await prefs.setBool("useDynamicColor", _useDynamicColor);
    await prefs.setBool("useMaterial3", _useMaterial3);
    await prefs.setBool("isImageMode", _isImageTheme);
  }

  void toggleMode() {
    _themeMode = !_themeMode;
    _saveToPrefs();
    notifyListeners();
  }

  void setThemeColor(Color color,{bool needBuild = true}) {
    _themeColor = color;
    _saveToPrefs();
    if (needBuild) {
      notifyListeners();
    }
  }

  void toggleDynamic() {
    _useDynamicColor = !_useDynamicColor;
    _saveToPrefs();
    notifyListeners();
  }

  void toggleMaterial3 () {
    _useMaterial3 = !_useMaterial3;
    _saveToPrefs();
    notifyListeners();
  }

  void toggleImageTheme (Color color) {
    _isImageTheme = !_isImageTheme;
    setThemeColor(color);
    _saveToPrefs();
    notifyListeners();
  }

  ThemeData get themeData {
    if (!_loaded) {
      return ThemeData(
        colorScheme: ColorScheme.fromSeed(brightness: Brightness.light, seedColor: Colors.green),
        brightness: Brightness.light,
        useMaterial3: true,
        fontFamily: "Noto",
      );
    }
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(brightness: _themeMode ? Brightness.light : Brightness.dark, seedColor: _themeColor),
      brightness: _themeMode ? Brightness.light : Brightness.dark,
      useMaterial3: _useMaterial3,
      fontFamily: "Noto",
    );
  }
}