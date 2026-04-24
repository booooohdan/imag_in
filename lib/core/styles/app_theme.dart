import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ColorScheme get colorScheme => ColorScheme.fromSeed(
    seedColor: Colors.teal,
    dynamicSchemeVariant: DynamicSchemeVariant.content,
  );

  static TextTheme get textTheme => TextTheme(
    displayLarge: GoogleFonts.comfortaa(
      letterSpacing: 0,
      fontSize: 57,
      height: 64 / 57,
      color: Colors.white,
    ),
    displayMedium: GoogleFonts.comfortaa(
      letterSpacing: 0,
      fontSize: 45,
      height: 52 / 45,
      color: Colors.white,
    ),
    displaySmall: GoogleFonts.comfortaa(
      letterSpacing: 0,
      fontSize: 36,
      height: 44 / 36,
      color: Colors.white,
    ),
    headlineLarge: GoogleFonts.comfortaa(
      letterSpacing: 0,
      fontSize: 32,
      height: 40 / 32,
      color: Colors.white,
    ),
    headlineMedium: GoogleFonts.comfortaa(
      letterSpacing: 0,
      fontSize: 28,
      height: 36 / 28,
      color: Colors.white,
    ),
    headlineSmall: GoogleFonts.comfortaa(
      letterSpacing: 0,
      fontSize: 24,
      height: 32 / 24,
      color: Colors.white,
    ),
    titleLarge: GoogleFonts.comfortaa(
      letterSpacing: 0,
      fontWeight: FontWeight.w700,
      fontSize: 18,
      height: 24 / 18,
      color: Colors.white,
    ),
    titleMedium: GoogleFonts.comfortaa(
      letterSpacing: 0,
      fontWeight: FontWeight.w700,
      fontSize: 16,
      height: 24 / 16,
      color: Colors.white,
    ),
    titleSmall: GoogleFonts.comfortaa(
      letterSpacing: 0,
      fontWeight: FontWeight.w700,
      fontSize: 14,
      height: 20 / 14,
      color: Colors.white,
    ),
    bodyLarge: GoogleFonts.comfortaa(
      letterSpacing: 0,
      fontSize: 16,
      height: 24 / 16,
      color: Colors.white,
    ),
    bodyMedium: GoogleFonts.comfortaa(
      letterSpacing: 0,
      fontSize: 14,
      height: 20 / 14,
      color: Colors.white,
    ),
    bodySmall: GoogleFonts.comfortaa(
      letterSpacing: 0,
      fontSize: 12,
      height: 16 / 12,
      color: Colors.white,
    ),
    labelLarge: GoogleFonts.comfortaa(
      letterSpacing: 0,
      fontWeight: FontWeight.w700,
      fontSize: 14,
      height: 20 / 14,
      color: Colors.white,
    ),
    labelMedium: GoogleFonts.comfortaa(
      letterSpacing: 0,
      fontWeight: FontWeight.w700,
      fontSize: 12,
      height: 16 / 12,
      color: Colors.white,
    ),
    labelSmall: GoogleFonts.comfortaa(
      letterSpacing: 0,
      fontWeight: FontWeight.w700,
      fontSize: 11,
      height: 16 / 11,
      color: Colors.white,
    ),
  );

  static final theme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: colorScheme,
    textTheme: textTheme,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
        TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
      },
    ),
    //* Icon Theme
    iconTheme: const IconThemeData(color: Colors.white),
    //* Input Decoration
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      labelStyle: textTheme.bodyMedium?.copyWith(color: Colors.teal),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.teal, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.teal.withValues(alpha: 0.3),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      hintStyle: textTheme.bodyMedium?.copyWith(
        color: Colors.teal.withValues(alpha: 0.3),
      ),
    ),
    //* Filled Button
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStateProperty.all(
          textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
        ),
        backgroundColor: WidgetStateProperty.all(Colors.orange),
        foregroundColor: WidgetStateProperty.all(Colors.white),
        minimumSize: WidgetStateProperty.all(const Size(64, 48)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
    ),
    //* Outlined Button
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStateProperty.all(
          textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
        ),
        backgroundColor: WidgetStateProperty.all(Colors.white),
        foregroundColor: WidgetStateProperty.all(Colors.orange),
        minimumSize: WidgetStateProperty.all(const Size(64, 48)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        side: WidgetStateProperty.all(
          const BorderSide(width: 2, color: Colors.orange),
        ),
      ),
    ),
    //* Floating Action Button
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      elevation: 0,
      backgroundColor: Colors.orange,
      foregroundColor: Colors.white,
      extendedTextStyle: textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w900,
      ),
      extendedSizeConstraints: const BoxConstraints(
        minWidth: 64,
        minHeight: 48,
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.white,
      contentTextStyle: textTheme.bodyLarge?.copyWith(color: Colors.teal),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );
}
