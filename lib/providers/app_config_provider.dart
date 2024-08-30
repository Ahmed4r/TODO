import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfigProvider extends ChangeNotifier {
  String _applanguage = 'en';
  ThemeMode _appTheme = ThemeMode.light;

  AppConfigProvider() {
    _loadSettings();
  }

  String get applanguage => _applanguage;
  ThemeMode get appTheme => _appTheme;

  Future<void> _loadSettings() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? savedLanguage = sharedPreferences.getString('applanguage');
    if (savedLanguage != null) {
      _applanguage = savedLanguage;
    }
    
    String? savedTheme = sharedPreferences.getString('appTheme');
    if (savedTheme != null) {
      _appTheme = savedTheme == 'dark' ? ThemeMode.dark : ThemeMode.light;
    }

    notifyListeners();  
  }

  Future<void> changeLanguage(String newLanguage) async {
    if (_applanguage == newLanguage) {
      return;
    }
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('applanguage', newLanguage);
    _applanguage = newLanguage;
    notifyListeners();  // Notify listeners after language change
  }

  Future<void> changeTheme(ThemeMode newTheme) async {
    if (_appTheme == newTheme) {
      return;
    }
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('appTheme', newTheme == ThemeMode.dark ? 'dark' : 'light');
    _appTheme = newTheme;
    notifyListeners();  // Notify listeners after theme change
  }

  bool isdarkmode() {
    return _appTheme == ThemeMode.dark;
  }
}
