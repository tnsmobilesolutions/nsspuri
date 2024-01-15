import 'package:flutter/material.dart';

class CommonStyle {
  static InputDecoration textFieldStyle({
    String labelTextStr = '',
    String hintTextStr = '',
    bool isRequired = false,
    Icon? suffixIcon, // Change the type to Icon
  }) {
    return InputDecoration(
      contentPadding: const EdgeInsets.all(12),
      labelText: labelTextStr,
      
      labelStyle: TextStyle(
          fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w400),
      hintText: hintTextStr,
      hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
      filled: true,
      fillColor: const Color.fromARGB(255, 190, 190, 190).withOpacity(0.3),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: const BorderSide(width: 0, style: BorderStyle.none),
      ),
      // Use suffixIcon to add an icon
      suffixIcon: suffixIcon,
    );
  }
}
