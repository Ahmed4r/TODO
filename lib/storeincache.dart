import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist/screens/languagesheet.dart';
import 'package:todolist/themeData.dart';

class PreferencesService {
  static const _themeKey = MyThemeData.routename;
  static const _languageKey =Languagesheet.routename;

  Future<void> setThemeMode(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, isDarkMode);
  }

  Future<bool> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_themeKey) ?? false; // default to light mode
  }

  Future<void> setLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, languageCode);
  }

  Future<String?> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_languageKey) ?? 'en'; // default to English
  }
}
