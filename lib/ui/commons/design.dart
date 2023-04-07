import 'package:flutter/material.dart';

class AppColors extends MaterialColor {
  static const int _primaryValue = 0xFF113455;

  AppColors()
      : super(_primaryValue, {
          50: const Color(0xFFE6E6E6),
          100: const Color(0xFFB3B3B3),
          200: const Color(0xFF808080),
          300: const Color(0xFF4D4D4D),
          400: const Color(0xFF262626),
          500: const Color(_primaryValue),
          600: const Color(0xFF000000),
          700: const Color(0xFF000000),
          800: const Color(0xFF000000),
          900: const Color(0xFF000000),
        });

  static const Color primaryColor = Color(0xFFffd60a);
  static const Color secondaryColor = Color(0xFFffc300);
  static const Color thirdColor = Color(0xFF003566);
  static const Color darkblue = Color(0xFF001d3d);
  static const Color darkGrey = Color.fromARGB(58, 158, 158, 158);
  static const Color black = Colors.black;
  static const Color white = Colors.white;
}

class AppStyle {
  static const OutlineInputBorder borderRad16 =
      OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16)));
  static const TextStyle f24 = TextStyle(
      fontSize: 24, color: AppColors.darkblue, fontWeight: FontWeight.w700);
  static const TextStyle f30 = TextStyle(
      fontSize: 30, color: AppColors.primaryColor, fontWeight: FontWeight.w700);
  static Decoration yellowBox = const BoxDecoration(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
      color: Color.fromARGB(255, 255, 240, 190));
}
