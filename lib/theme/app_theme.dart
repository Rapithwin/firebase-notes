import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get dark {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontFamily: "Allerta",
          fontWeight: FontWeight.w500,
          fontSize: 28,
          letterSpacing: 1.3,
        ),
      ),
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: Color(0xff8A38F5),
        surface: Color(0xff151515),
        primary: Color(0xff8A38F5),
        secondary: Color(0xff958DA5),
        tertiary: Color(0xffFB80FF),
        outline: Color(0xff868686),
        onPrimary: Color(0xffEBEBEB),
      ),
    );
  }

  static ThemeData get light {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontFamily: "Allerta",
          fontWeight: FontWeight.w500,
          fontSize: 28,
          letterSpacing: 1.3,
          color: Color(0xff151515),
        ),
      ),
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light,
        seedColor: Color(0xff8A38F5),
        surface: Color(0xffEBEBEB),
        onSurface: Color(0xff151515),
        primary: Color(0xffC194FB),
        onPrimary: Color(0xff3F334F),
        secondary: Color.fromARGB(255, 107, 102, 116),
        tertiary: Color(0xff7D5260),
        outline: Color(0xff868686),
      ),
    );
  }
}
