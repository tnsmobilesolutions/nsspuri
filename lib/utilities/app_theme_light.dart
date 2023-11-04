// app_theme.dart

import 'package:flutter/material.dart';
import 'package:sammilani_delegate/utilities/color_palette.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: Colors.deepOrange, // Set your primary color
  hintColor: Colors.grey, // Set your accent color
  textTheme: const TextTheme(

      // Define your text styles here
      headlineSmall: TextStyle(),
      bodyLarge: TextStyle(),
      bodySmall: TextStyle(),
      // use for textformField
      displaySmall: TextStyle(),
      // use for cards
      displayMedium: TextStyle(
          fontSize: 14, color: TextThemeColor, fontWeight: FontWeight.w200),
      displayLarge: TextStyle(),
      // use for button text
      titleSmall: TextStyle(
          fontSize: 14,
          color: ButtonTextStyleColor,
          fontWeight: FontWeight.bold),
      // use for appBar
      titleMedium: TextStyle(
          fontSize: 16, color: TextThemeColor, fontWeight: FontWeight.w300),
      titleLarge: TextStyle()),
  // Define other theme properties here
);
