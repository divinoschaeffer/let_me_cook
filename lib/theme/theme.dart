import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFF58351),
      brightness: Brightness.light,
      primary: const Color(0xFFF58351), // Orange: F58351
      secondary: const Color(0xFFFFD3C0), // Light Peach: FFD3C0
    ),
    appBarTheme: const AppBarTheme(
      color: Color(0xFF1E1E1E), // Dark Gray: 1E1E1E
    ),
    textTheme: GoogleFonts.nunitoTextTheme()
  );
}