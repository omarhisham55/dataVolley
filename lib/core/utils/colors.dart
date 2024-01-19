import 'package:flutter/material.dart';

class MainColors {
  static const Color primaryColor = Color(0xFF212121);
  static const Color secondaryColor = Color.fromARGB(255, 52, 52, 52);
  static const Color waringColor = Colors.amber;
  static const Color errorColor = Colors.red;
  static const Color buttonColor = Color.fromARGB(255, 191, 0, 255);
  static const Color splashButtonColor = Color.fromARGB(255, 214, 90, 255);
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF212121), Color(0xFF303030)],
  );
}
