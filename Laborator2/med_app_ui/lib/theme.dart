import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF0EBE7E);
  static const Color bg      = Color(0xFFF9F9F9);   // fundal ecran
  static const Color card    = Colors.white;        // card alb
  static const Color border  = Color(0xFFE5E7EB);   // gri deschis pentru borduri
  static const Color text    = Color(0xFF222222);   // text principal
  static const Color subtext = Color(0xFF6B7280);   // text secundar
  static const Color pill    = Color(0xFFE6F7F1);   // „pill” chips/butoane
}

// radius ca DOUBLE (așa îl cere BorderRadius.circular)
const double kRadius12 = 12.0;
const double kRadius16 = 16.0;
const double kRadius22 = 22.0;

// gaps rapide
const SizedBox kGap8  = SizedBox(height: 8);
const SizedBox kGap12 = SizedBox(height: 12);
const SizedBox kGap16 = SizedBox(height: 16);

// Tema folosită în main.dart
ThemeData buildTheme() {
  return ThemeData(
    scaffoldBackgroundColor: AppColors.bg,
    fontFamily: 'Poppins',
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black87),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: AppColors.text),
    ),
  );
}
