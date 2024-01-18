import 'dart:ui';

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  final double width;
  final double fontSize;

  const CustomTextField({
    required this.controller,

    required this.labelText,
    this.obscureText = false,
    this.width = 200.0, // Set the desired fixed width
    this.fontSize = 16.0, // Set the desired font size

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,

      child: TextField(
        controller: controller,
        style: TextStyle(fontSize: fontSize),

        decoration: InputDecoration(
          labelText: labelText,

          border: OutlineInputBorder(),
        ),
        obscureText: obscureText,
      ),
    );
  }
}
