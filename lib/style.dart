import 'package:flutter/material.dart';

class SCol {
  static Color primary = Colors.orange; //Colors.grey[350]!;
  static Color secondary = Colors.lightGreen;
  static Color background = Colors.white;
  static Color onBackground = Colors.black;
  static Color onPrimary = const Color(0xFFDCFFFD);
  static Color onSecondary = Colors.black;
  static Color red = Colors.red;
  static Color grey = Colors.grey[200]!;

  // gold, silver, bronze
  static Color gold = const Color(0xFFF0D700);
  static Color silver = const Color(0xFFC0C0C0);
  static Color bronze = const Color(0xFFCD7F32);

  static Color foreground = Colors.grey[800]!;

  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}

class Style {}
