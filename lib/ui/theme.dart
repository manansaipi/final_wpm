import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// const Color primaryClr2 = Color(0xFF4e5ae8);
const Color primaryClr = Color.fromARGB(255, 105, 173, 252);
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

TextStyle get deleteTitleStyle {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 255, 0, 0)),
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

TextStyle get biggerHeadingStyle {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.bold,
      color: primaryClr,
    ),
  );
}

TextStyle get titleHeadingStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? Colors.white : Colors.grey.shade700,
    ),
  );
}

TextStyle get titleStyle2 {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? Colors.grey.shade300 : Colors.grey.shade700,
    ),
  );
}

TextStyle get hintStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? Colors.grey.shade500 : Colors.grey.shade500,
    ),
  );
}

TextStyle get inputFieldStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? Colors.white : Colors.grey.shade900,
    ),
  );
}

TextStyle get titleBiggerHeadingStyle {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: primaryClr,
    ),
  );
}

TextStyle get titleBiggerHeadingStyle2 {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 27,
      fontWeight: FontWeight.bold,
      color: primaryClr,
    ),
  );
}

TextStyle get taskTileNote {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 15,
      color: Get.isDarkMode ? Colors.white : Colors.black,
    ),
  );
}

TextStyle get taskTileTime {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 13,
      color: Get.isDarkMode ? Colors.grey.shade300 : Colors.grey.shade600,
    ),
  );
}

TextStyle get titleIntroductionScreen {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 70, 65, 65),
    ),
  );
}

TextStyle get titleIntroductionScreen2 {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 35,
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 70, 65, 65),
    ),
  );
}

TextStyle get titleIntroductionScreenColor1 {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 35,
      fontWeight: FontWeight.bold,
      color: primaryClr,
    ),
  );
}

TextStyle get titleIntroductionScreenColor2 {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 35,
      fontWeight: FontWeight.bold,
      color: Colors.pink,
    ),
  );
}

TextStyle get titleIntroductionScreenColor3 {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 35,
      fontWeight: FontWeight.bold,
      color: Colors.yellow,
    ),
  );
}

TextStyle get noteIntroScreen {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 17,
      color: Colors.grey.shade700,
    ),
  );
}
