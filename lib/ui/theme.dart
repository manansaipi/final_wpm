import 'dart:ui';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryClr = Color(0xFF4e5ae8);
const Color darkBGColor = Color(0xFF303030);

class Themes {
  // ignore: non_constant_identifier_names
  static final light = ThemeData(
    backgroundColor: Colors.white,
    // colorSchemeSeed: Colors.red,
    brightness: Brightness.light,
  );

  static final dark = ThemeData(
    backgroundColor: Colors.grey[800],
    // primaryColor: Colors.grey,
    brightness: Brightness.dark,
  );
}

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Get.isDarkMode ? Colors.grey[400] : Colors.grey),
  );
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.bold,
        color: Get.isDarkMode ? Colors.white : Colors.black),
  );
}

TextStyle get subTitleStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.normal,
        color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[600]),
  );
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? Colors.white : Colors.black,
    ),
  );
}
