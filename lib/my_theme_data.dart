import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyThemeData {
  static ThemeData get light {
    return ThemeData.light().copyWith(
      textTheme: ThemeData.light().textTheme.copyWith(
            displayLarge: TextStyle(
              fontSize: 52,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.bebasNeue().fontFamily,
              color: Colors.black87,
            ),
            displayMedium: const TextStyle(
              fontSize: 20,
              color: Colors.black26,
            ),
          ),
    );
  }
}
