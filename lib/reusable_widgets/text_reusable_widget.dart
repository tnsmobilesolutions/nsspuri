import 'dart:ui';

import 'package:flutter/material.dart';

Color getTextColorForBackground(Color backgroundColor) {
  if (ThemeData.estimateBrightnessForColor(backgroundColor) ==
      Brightness.dark) {
    return Colors.white;
  }

  return Colors.black;
}
