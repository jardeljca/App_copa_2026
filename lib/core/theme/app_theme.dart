import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color emerald500 = Color(0xFF00E676);
  static const Color background = Color(0xFF0D0D0D);
  static const Color cardBg = Color(0xFF161616);
  static const Color borderSide = Color(0x14FFFFFF);

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: background,
    colorScheme: const ColorScheme.dark(
      primary: emerald500,
      surface: cardBg,
      onSurface: Colors.white,
    ),
    textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme).copyWith(
      displayLarge: GoogleFonts.outfit(fontWeight: FontWeight.black, letterSpacing: -1),
      displayMedium: GoogleFonts.outfit(fontWeight: FontWeight.black, letterSpacing: -0.5),
      headlineMedium: GoogleFonts.outfit(fontWeight: FontWeight.bold, letterSpacing: -0.5),
      bodyMedium: GoogleFonts.geist(color: Colors.white.withOpacity(0.9)),
    ),
    cardTheme: CardTheme(
      color: cardBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
        side: const BorderSide(color: borderSide),
      ),
      elevation: 0,
    ),
  );

  static ThemeData lightTheme = darkTheme; // Mantendo dark como prioritário
}
