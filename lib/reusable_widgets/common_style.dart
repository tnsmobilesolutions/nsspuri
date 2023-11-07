import 'package:flutter/material.dart';

class CommonStyle {
  static InputDecoration textFieldStyle(Set<Object> set, 
      {String labelTextStr = "", String hintTextStr = ""}) {
    return InputDecoration(
      contentPadding: const EdgeInsets.all(12),
      labelText: labelTextStr,
      hintText: hintTextStr,
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: const BorderSide(width: 0, style: BorderStyle.none),
      ),
    );
  }
}
