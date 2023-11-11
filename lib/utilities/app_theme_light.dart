// app_theme.dart

import 'package:flutter/material.dart';
import 'package:sammilani_delegate/utilities/color_palette.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: Colors.deepOrange, // Set your primary color
  hintColor: const Color.fromARGB(255, 27, 27, 27), // Set your accent color
  textTheme: const TextTheme(
    // Define your text styles here
    headlineSmall: TextStyle(),
    bodyLarge: TextStyle(),
    bodySmall: TextStyle(),

    // use for textformField
    displaySmall: TextStyle(
      fontSize: 14,
      color: TextFormFieldColor,
      fontWeight: FontWeight.normal,
    ),

    // use for cards
    displayMedium: TextStyle(
        fontSize: 14, color: TextThemeColor, fontWeight: FontWeight.bold),
    displayLarge: TextStyle(),

    // use for button text
    titleSmall: TextStyle(
        fontSize: 14, color: ButtonTextStyleColor, fontWeight: FontWeight.bold),

    // use for appBar
    titleMedium: TextStyle(
        fontSize: 20, color: AppbarTextColor, fontWeight: FontWeight.bold),

    titleLarge: TextStyle(),
  ),

  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor:
          MaterialStateProperty.all(Colors.deepOrange), // Text color
      backgroundColor: MaterialStateProperty.all(
          ScaffoldBackgroundColor), // Background color
      padding: MaterialStateProperty.all(const EdgeInsets.all(16)), // Padding
      textStyle: MaterialStateProperty.all(
        const TextStyle(fontSize: 16), // Text style
      ),
    ),
  ),

 
  // Define other theme properties here
);
