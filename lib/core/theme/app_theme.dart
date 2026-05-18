import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color emerald500 = Color(0xFF00E676);
  static const Color background = Color(0xFF0F1115);
  static const Color cardBg = Color(0xFF0F1214);
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
      displayLarge: GoogleFonts.outfit(fontWeight: FontWeight.w900, letterSpacing: -1),
      displayMedium: GoogleFonts.outfit(fontWeight: FontWeight.w900, letterSpacing: -0.5),
      headlineMedium: GoogleFonts.outfit(fontWeight: FontWeight.bold, letterSpacing: -0.5),
      bodyMedium: GoogleFonts.outfit(color: Colors.white.withOpacity(0.92)),
    ),
    // cardTheme removed temporarily to avoid SDK type mismatch on this system
  );

  static ThemeData lightTheme = darkTheme; // Mantendo dark como prioritário
}
