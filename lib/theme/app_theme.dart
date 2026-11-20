import 'package:flutter/material.dart';

/// Tema dasar yang mengikuti token warna web (static/css/style.css).
/// Font memakai bawaan platform; font web (DM Sans/Manrope) belum dipasang.
class AppTheme {
  const AppTheme._();

  static ThemeData get light => _build(
        brightness: Brightness.light,
        primary: const Color(0xFF216C4C),
        onPrimary: Colors.white,
        surface: Colors.white,
        background: const Color(0xFFF6F7F1),
        ink: const Color(0xFF1C3029),
        muted: const Color(0xFF607168),
        line: const Color(0xFFE1E7DB),
        error: const Color(0xFF9B1C1C),
        errorContainer: const Color(0xFFFDE8E8),
        accent: const Color(0xFFD9EEA9),
      );

  static ThemeData get dark => _build(
        brightness: Brightness.dark,
        primary: const Color(0xFF7CCFA3),
        onPrimary: const Color(0xFF0C1F16),
        surface: const Color(0xFF16241F),
        background: const Color(0xFF0F1A16),
        ink: const Color(0xFFE4ECE6),
        muted: const Color(0xFFA3B5AA),
        line: const Color(0xFF2A3C35),
        error: const Color(0xFFF3A6A6),
        errorContainer: const Color(0xFF3A1A1A),
        accent: const Color(0xFF2A3C35),
      );

  static ThemeData _build({
    required Brightness brightness,
    required Color primary,
    required Color onPrimary,
    required Color surface,
    required Color background,
    required Color ink,
    required Color muted,
    required Color line,
    required Color error,
    required Color errorContainer,
    required Color accent,
  }) {
    final scheme = ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      secondary: accent,
      onSecondary: ink,
      error: error,
      onError: onPrimary,
      errorContainer: errorContainer,
      onErrorContainer: error,
      surface: surface,
      onSurface: ink,
      onSurfaceVariant: muted,
      outline: line,
      outlineVariant: line,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: background,
      appBarTheme: AppBarTheme(
        backgroundColor: primary,
        foregroundColor: onPrimary,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: line),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(9)),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(48, 48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
        ),
      ),
    );
  }
}
