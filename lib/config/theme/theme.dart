import 'package:data_volley_match/core/utils/colors.dart';
import 'package:flutter/material.dart';

ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: MainColors.primaryColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: MainColors.primaryColor,
    iconTheme: IconThemeData(color: Colors.white),
  ),
  iconTheme: const IconThemeData(color: Colors.white),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Colors.white),
    displayMedium: TextStyle(color: Colors.white),
    titleSmall: TextStyle(color: Colors.white),
    titleMedium: TextStyle(color: Colors.white),
    headlineLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    headlineMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    headlineSmall: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    labelLarge: TextStyle(color: Colors.grey),
    bodyLarge: TextStyle(color: Colors.grey),
    bodySmall: TextStyle(color: Colors.grey),
  ),
  dropdownMenuTheme: const DropdownMenuThemeData(
    menuStyle: MenuStyle(
      backgroundColor: MaterialStatePropertyAll(MainColors.primaryColor),
    ),
  ),
);
