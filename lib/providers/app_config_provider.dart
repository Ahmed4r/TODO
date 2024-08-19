import 'package:flutter/material.dart';

class AppConfigProvider extends ChangeNotifier {
//data when changes it change more than widget in local
  String applanguage = 'ar';
  ThemeMode appTheme = ThemeMode.light;
  void changeLanguage(String newLanguage) {
    if (applanguage == newLanguage) {
      return;
    }
    applanguage = newLanguage;
    notifyListeners()
        // like setstate.
        ;
  }

  void changeTheme(ThemeMode newTheme) {
    if (appTheme == newTheme) {
      return;
    }
    appTheme = newTheme;
    notifyListeners()
        // like setstate.
        ;
  }

  bool isdarkmode() {
    return appTheme == ThemeMode.dark;
  }
}
