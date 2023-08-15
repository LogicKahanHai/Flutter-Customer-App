import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PKTheme {
  static const Color primaryColor = Color(0xFFff6b00);
  static const Color bottomNavBarBg = Color(0xFFF8E9E4);

  static ButtonStyle hollowButtonWithBorder = ButtonStyle(
    overlayColor: MaterialStateProperty.resolveWith(
        (states) => const Color.fromRGBO(255, 107, 0, 0.42)),
    backgroundColor:
        MaterialStateProperty.resolveWith((states) => Colors.transparent),
    foregroundColor:
        MaterialStateProperty.resolveWith((states) => PKTheme.primaryColor),
    shape: MaterialStateProperty.resolveWith(
      (states) => RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: const BorderSide(
          color: PKTheme.primaryColor,
          width: 2.0,
        ),
      ),
    ),
    shadowColor:
        MaterialStateProperty.resolveWith((states) => Colors.transparent),
  );

  static ButtonStyle hollowButtonWithoutBorder = ButtonStyle(
    overlayColor: MaterialStateProperty.resolveWith(
        (states) => const Color.fromRGBO(255, 107, 0, 0.42)),
    backgroundColor:
        MaterialStateProperty.resolveWith((states) => Colors.transparent),
    foregroundColor:
        MaterialStateProperty.resolveWith((states) => PKTheme.primaryColor),
    shape: MaterialStateProperty.resolveWith(
      (states) => RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
    shadowColor:
        MaterialStateProperty.resolveWith((states) => Colors.transparent),
  );

  static ButtonStyle normalElevatedButton = ElevatedButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: primaryColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
  );

  static final ThemeData themeData = ThemeData(
    primaryColor: primaryColor,
    primaryColorDark: primaryColor,
    primaryColorLight: primaryColor,
    hintColor: primaryColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0.0,
      iconTheme: IconThemeData(
        color: primaryColor,
      ),
    ),
    fontFamily: Platform.isIOS ? GoogleFonts.dmSans().fontFamily : null,
    textTheme: const TextTheme(
      displaySmall: TextStyle(
        color: primaryColor,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryColor,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          color: primaryColor,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          color: primaryColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          color: primaryColor,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          color: primaryColor,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          color: primaryColor,
        ),
      ),
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: Colors.orange,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: bottomNavBarBg,
    ),
  );
  // static const Color primaryColorDark = Color(0xFFc43e00);
}
