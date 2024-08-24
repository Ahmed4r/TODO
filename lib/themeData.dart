import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todolist/appcolor.dart';

class MyThemeData {
  static final ThemeData ligthTheme = ThemeData(
      primaryColor: Appcolors.blueColor,
      scaffoldBackgroundColor: Appcolors.backgroundLightColor,
      appBarTheme: AppBarTheme(
        color: Appcolors.blueColor,
        elevation: 0,
      ),
    
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          showUnselectedLabels: false,
          selectedItemColor: Appcolors.blueColor,
          unselectedItemColor: Appcolors.grey),
      textTheme: TextTheme(
          bodyLarge: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Appcolors.whiteColor)),
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: Appcolors.blueColor),
      bottomSheetTheme: BottomSheetThemeData(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: Appcolors.blueColor, width: 2))));
  static final ThemeData darkTheme = ThemeData(
    primaryColor: Appcolors.blueColor,
    scaffoldBackgroundColor: Appcolors.backgroundDarkColor,
    appBarTheme: AppBarTheme(
      color: Appcolors.blueColor,
      elevation: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        unselectedItemColor: Appcolors.grey,
        selectedItemColor: Appcolors.blueColor,
        showUnselectedLabels: false),
    textTheme: TextTheme(
        bodyLarge: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Appcolors.blackColorText)),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: Appcolors.blueColor),
    bottomSheetTheme: BottomSheetThemeData(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Appcolors.blueColor, width: 2))),
    
  );
}
