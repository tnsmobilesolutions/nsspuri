import 'package:flutter/material.dart';

const Color bluishClr = Color(0xFF4e5ae8);
const Color yellowClr = Color(0xFF9CBB2B);
const Color pinkClr = Color(0xFFB742BB);
const Color white = Color(0xFFFFFFFF);
const primaryClr = Color(0xFFB4DA1B);
const Color darkGreyClr = Color(0xFF35353D);
const Color darkHeaderClr = Color(0xFF161720);

class Themes {
  static final light = ThemeData(
    primaryColor: primaryClr,
    brightness: Brightness.light,
    textTheme: TextTheme(
      bodyText1:
          TextStyle(color: Colors.black), // Set the default text color to black
      bodyText2: TextStyle(
          color: Colors.black), // You can customize other text styles as well
    ),
  );

  static final dark =
      ThemeData(primaryColor: darkGreyClr, brightness: Brightness.dark);
}
