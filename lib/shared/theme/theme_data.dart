import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LightThemeData {
  @lazySingleton
  ThemeData get themeData => ThemeData(
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: _textTheme,
    elevatedButtonTheme: _elevatedButtonTheme,
    useMaterial3: true,
  );

  ColorScheme get colorScheme => ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFFFF8F00),
    // Amber 800
    onPrimary: Color(0xFF000000),
    // Black
    primaryContainer: Color(0xFFFFA000),
    // Amber 700
    onPrimaryContainer: Color(0xFF000000),

    secondary: Color(0xFFD81B60),
    // Secondary
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFAD1457),
    // Secondary Container
    onSecondaryContainer: Color(0xFFFFFFFF),

    tertiary: Color(0xFF2F82C5),
    // Tertiary
    onTertiary: Color(0xFF000000),
    tertiaryContainer: Color(0xFF5C95C4),
    // Tertiary Container
    onTertiaryContainer: Color(0xFF000000),

    surface: Color(0xFFF2F2F2),
    // Light surface
    onSurface: Color(0xFF000000),

    error: Color(0xFFCF6679),
    // Error
    onError: Color(0xFF000000),
    errorContainer: Color(0xFF8C1D18),
    onErrorContainer: Color(0xFFF9DEDC),
  );

  TextTheme get _textTheme => TextTheme(
    displayLarge: TextStyle(
      fontSize: 57,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.25,
      decorationThickness: 0,
    ),
    displayMedium: TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.w400,
      decorationThickness: 0,
    ),
    displaySmall: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w400,
      decorationThickness: 0,
    ),
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w400,
      decorationThickness: 0,
    ),
    headlineMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w400,
      decorationThickness: 0,
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      decorationThickness: 0,
    ),
    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w500,
      decorationThickness: 0,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      decorationThickness: 0,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      decorationThickness: 0,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      decorationThickness: 0,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      decorationThickness: 0,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      decorationThickness: 0,
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      decorationThickness: 0,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      decorationThickness: 0,
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      decorationThickness: 0,
    ),
  );

  ElevatedButtonThemeData get _elevatedButtonTheme => ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
    ),
  );
}

@lazySingleton
class DarkThemeData extends LightThemeData {
  @override
  @lazySingleton
  ThemeData get themeData => super.themeData.copyWith(
    brightness: this.colorScheme.brightness,
    colorScheme: this.colorScheme,
  );

  @override
  ColorScheme get colorScheme => ColorScheme.dark().copyWith(
    brightness: Brightness.dark,

    primary: Color(0xFFFF8F00),
    // Amber 800
    onPrimary: Color(0xFF000000),
    primaryContainer: Color(0xFFFFA000),
    onPrimaryContainer: Color(0xFF000000),

    secondary: Color(0xFFD81B60),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFAD1457),
    onSecondaryContainer: Color(0xFFFFFFFF),

    tertiary: Color(0xFF2B82C2),
    onTertiary: Color(0xFF000000),
    tertiaryContainer: Color(0xFF5691BD),
    onTertiaryContainer: Color(0xFF000000),

    surface: Color(0xFF1E1E1E),
    onSurface: Color(0xFFE0E0E0),

    error: Color(0xFFCF6679),
    onError: Color(0xFF000000),
    errorContainer: Color(0xFF8C1D18),
    onErrorContainer: Color(0xFFF9DEDC),
  );
}
