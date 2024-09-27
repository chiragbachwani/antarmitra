import 'package:flutter/material.dart';

class FontSizes {
  static const extraSmall = 14.0;
  static const small = 16.0;
  static const standard = 18.0;
  static const large = 20.0;
  static const extraLarge = 24.0;
  static const doubleExtraLarge = 26.0;
}

ThemeData lightMode = ThemeData(
  fontFamily: 'Nunito',
  brightness: Brightness.light,
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
    shadowColor: Colors.white,
  ),
  colorScheme: const ColorScheme.light(
    surface: Color(0xffffffff),  // White background
    primary: Color(0xff3369FF),     // Primary blue
    secondary: Color(0xffEEEEEE),   // Light secondary color for outlines, dividers
  ),
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(color: Colors.blue),
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(color: Color(0xff000000)), // Black titles
    titleSmall: TextStyle(
      color: Color(0xff000000),
    ),
    bodyMedium: TextStyle(
      color: Color(0xffEEEEEE),
      fontSize: FontSizes.small,
    ),
    bodySmall: TextStyle(
      color: Color(0xff000000),
      fontSize: FontSizes.small,
    ),
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(
    shadowColor: Color(0xff625b5b),  // Subtle shadow for app bar
  ),
  colorScheme: const ColorScheme.dark(
    surface: Color(0xff121212),    // Dark gray background
    primary: Color(0xff2A57CC),       // Subdued blue for primary color
    secondary: Color(0xffA0A0A0),     // Soft light gray for secondary elements
  ),
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(color: Color(0xffA0A0A0)), // Soft gray label colors
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(color: Color(0xffE0E0E0)), // Light gray for titles
    titleSmall: TextStyle(
      color: Color(0xffE0E0E0),
    ),
    bodyMedium: TextStyle(
      color: Color(0xffEEEEEE), // White text for main content
      fontSize: FontSizes.small,
    ),
    bodySmall: TextStyle(
      color: Color(0xff9E9E9E), // Softer gray for secondary text
      fontSize: FontSizes.small,
    ),
  ),
);
