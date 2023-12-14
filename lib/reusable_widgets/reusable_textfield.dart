import 'package:flutter/material.dart';

class ReusableTextField extends StatelessWidget {
  final String label;

  final TextEditingController controller;
  final TextInputType keyboardType;
 

  ReusableTextField({
    required this.label,
    required this.controller,
    this.keyboardType = TextInputType.text,
  });
  String labelTextStr = "";
  String hintTextStr = "";

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        keyboardType: keyboardType,
        cursorColor: Colors.black,
        style: TextStyle(color: Colors.black.withOpacity(0.9)),
        decoration: InputDecoration(
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
            borderRadius: BorderRadius.circular(40.0),
            borderSide: const BorderSide(width: 0, style: BorderStyle.none),
          ),
        ));
  }
}
