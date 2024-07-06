import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyThemeData {
  static ThemeData get light {
    return ThemeData.light().copyWith(
      textTheme: ThemeData.light().textTheme.copyWith(
            titleLarge: TextStyle(
              fontSize: 52,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.bebasNeue().fontFamily,
            ),
            displayMedium: const TextStyle(
              fontSize: 20,
            ),
          ),
    );
  }
}
