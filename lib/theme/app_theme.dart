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

      textTheme: TextTheme(
        displayLarge: TextStyle(fontFamily: "Allerta"),
        displayMedium: TextStyle(fontFamily: "Allerta"),
        displaySmall: TextStyle(fontFamily: "Allerta"),
        headlineLarge: TextStyle(fontFamily: "Allerta"),
        headlineMedium: TextStyle(fontFamily: "Allerta"),
        headlineSmall: TextStyle(fontFamily: "Allerta"),
        titleLarge: TextStyle(fontFamily: "DidactGothic"),
        titleMedium: TextStyle(fontFamily: "DidactGothic"),
        titleSmall: TextStyle(fontFamily: "DidactGothic"),
        labelLarge: TextStyle(fontFamily: "Inter"),
        labelMedium: TextStyle(fontFamily: "Inter"),
        labelSmall: TextStyle(fontFamily: "Inter"),
        bodyLarge: TextStyle(fontFamily: "Inter"),
        bodyMedium: TextStyle(fontFamily: "Inter"),
        bodySmall: TextStyle(fontFamily: "Inter"),
      ),
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: Color(0xff6750A4),
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
      textTheme: TextTheme(
        displayLarge: TextStyle(fontFamily: "Allerta"),
        displayMedium: TextStyle(fontFamily: "Allerta"),
        displaySmall: TextStyle(fontFamily: "Allerta"),
        headlineLarge: TextStyle(fontFamily: "Allerta"),
        headlineMedium: TextStyle(fontFamily: "Allerta"),
        headlineSmall: TextStyle(fontFamily: "Allerta"),
        titleLarge: TextStyle(fontFamily: "DidactGothic"),
        titleMedium: TextStyle(fontFamily: "DidactGothic"),
        titleSmall: TextStyle(fontFamily: "DidactGothic"),
        labelLarge: TextStyle(fontFamily: "Inter"),
        labelMedium: TextStyle(fontFamily: "Inter"),
        labelSmall: TextStyle(fontFamily: "Inter"),
        bodyLarge: TextStyle(fontFamily: "Inter"),
        bodyMedium: TextStyle(fontFamily: "Inter"),
        bodySmall: TextStyle(fontFamily: "Inter"),
      ),
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light,
        seedColor: Color(0xff6750A4),
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
