import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyThemeModel extends ChangeNotifier {
  Color _themeColor = Colors.green;
  bool _themeMode = true; //true是白天，false是黑夜
  bool _loaded = false;
  bool _useDynamicColor = false;
  bool _useMaterial3 = true;
  bool _followSystem = false;

  Color get themeColor => _themeColor;

  bool get themeMode => _themeMode;

  bool get useDynamicColor => _useDynamicColor;

  bool get useMaterial3 => _useMaterial3;

  bool get followSystem => _followSystem;

  MyThemeModel() {
    _loadFromPrefs();
    WidgetsBinding.instance.platformDispatcher.onPlatformBrightnessChanged = () {
      if (_followSystem) {
        notifyListeners();
      }
    };
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _themeColor = Color(prefs.getInt("themeColor") ?? 0xFF4CAF50);
    _themeMode = prefs.getBool("themeMode") ?? true;
    _useDynamicColor = prefs.getBool("useDynamicColor") ?? false;
    _useMaterial3 = prefs.getBool("useMaterial3") ?? true;
    _followSystem = prefs.getBool("followSystem") ?? false;
    _loaded = true;
    notifyListeners();
  }

  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("themeColor", _themeColor.toARGB32());
    await prefs.setBool("themeMode", _themeMode);
    await prefs.setBool("useDynamicColor", _useDynamicColor);
    await prefs.setBool("useMaterial3", _useMaterial3);
    await prefs.setBool("followSystem", _followSystem);
  }

  void toggleMode() {
    if (!_followSystem) {
      _themeMode = !_themeMode;
      _saveToPrefs();
      notifyListeners();
    }
  }

  void setThemeColor(
    Color color, {
    bool needBuild = true,
    bool fromPicker = true,
  }) {
    _themeColor = color;
    if (fromPicker) {
      _useDynamicColor = false;
    }
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

  void toggleMaterial3() {
    _useMaterial3 = !_useMaterial3;
    _saveToPrefs();
    notifyListeners();
  }

  void toggleFollowSystem() {
    _followSystem = !_followSystem;
    _saveToPrefs();
    notifyListeners();
  }

  ThemeData get themeData {
    final currentBrightness = _followSystem
        ? WidgetsBinding.instance.platformDispatcher.platformBrightness
        : (_themeMode ? Brightness.light : Brightness.dark);
    if (!_loaded) {
      return ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.light,
          seedColor: Colors.green,
        ),
        brightness: Brightness.light,
        useMaterial3: true,
        fontFamily: "Noto",
      );
    }
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        brightness: currentBrightness,
        seedColor: _themeColor,
      ),
      brightness: currentBrightness,
      useMaterial3: _useMaterial3,
      fontFamily: "Noto",
    );
  }
}