import 'package:flutter/material.dart';

class GlobalVariables {
  static Color primaryColor = const Color(0xFFfb5607);
  static Color bgColor = const Color(0xFFfdf0d5);
  static Color secondaryColor = const Color(0xFF0077b6);
  static Color iconColor = const Color(0xFF219ebc);
  static Color gameColor = const Color(0xFF90e0ef);
  static Color textColor = const Color(0xFF023047);

  static TextStyle textStyle = TextStyle(
    fontSize: 16,
    color: textColor,
    fontWeight: FontWeight.w500,
  );
  static TextStyle headLineStyle1 = TextStyle(
    fontSize: 26,
    color: textColor,
    fontWeight: FontWeight.bold,
  );
  static TextStyle headLineStyle2 = TextStyle(
    fontSize: 21,
    color: textColor,
    fontWeight: FontWeight.bold,
  );
  static TextStyle headLineStyle3 = TextStyle(
    fontSize: 17,
    color: Colors.grey.shade500,
    fontWeight: FontWeight.w500,
  );
  static TextStyle headLineStyle4 = TextStyle(
    fontSize: 14,
    color: Colors.grey.shade500,
    fontWeight: FontWeight.w500,
  );
}
