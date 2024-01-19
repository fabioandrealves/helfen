import 'package:flutter/material.dart';

class Scheme {
  final Brightness brightness;
  final Color primary;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color outline;
  final Color outlineVariant;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color inverseSurface;
  final Color onInverseSurface;
  final Color inversePrimary;
  final Color shadow;
  final Color scrim;

  Scheme({
    required this.brightness,
    required this.primary,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.outline,
    required this.outlineVariant,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.inverseSurface,
    required this.onInverseSurface,
    required this.inversePrimary,
    required this.shadow,
    required this.scrim,
  });

  factory Scheme.light(
    Color seedColor,
    Brightness brightness,
  ) {
    // Colors for the light mode
    const background = Colors.white; // Light background
    const textDark = Colors.black; // Dark text
    const textLight = Colors.white; // Light text
    const errorColor = Colors.red; // Error color

    return Scheme(
      brightness: Brightness.light,
      primary: const Color(0xFF007ACC),
      // Primary blue
      onPrimary: textLight,
      primaryContainer: const Color(0xFF003366),
      // Primary container background color
      onPrimaryContainer: textLight,
      secondary: const Color(0xFFFF9900),
      // Secondary color
      onSecondary: background,
      secondaryContainer: const Color(0xFFCC6600),
      // Secondary container background color
      onSecondaryContainer: textLight,
      tertiary: const Color(0xFF00CC66),
      // Tertiary color
      onTertiary: background,
      tertiaryContainer: const Color(0xFF006633),
      // Tertiary container background color
      onTertiaryContainer: textLight,
      error: errorColor,
      onError: background,
      errorContainer: const Color(0xFF660000),
      // Error container background color
      onErrorContainer: textLight,
      outline: const Color(0xFF999999),
      // Border color
      outlineVariant: const Color(0xFF666666),
      // Border color variant
      background: background,
      onBackground: textDark,
      // Text on light background
      surface: background,
      onSurface: textDark,
      // Text on light surface
      surfaceVariant: const Color(0xFFEEEEEE),
      // Surface color variant
      onSurfaceVariant: textDark,
      // Text on light surface variant
      inverseSurface: textLight,
      // Text on inverse surface
      onInverseSurface: background,
      // Background on inverse surface
      inversePrimary: background,
      // Inverse primary background
      shadow: const Color(0x33000000),
      // Shadow (used with transparency)
      scrim: const Color(0x33000000)
          .withAlpha(255), // Scrim (used with transparency)
    );
  }

  factory Scheme.dark(
    Color seedColor,
    Brightness brightness,
  ) {
    // Colors for the dark mode
    const darkBackgroundColor = Colors.black; // Dark background
    const lightTextColor = Colors.white; // Light text
    const darkTextColor = Colors.black; // Dark text
    const errorColor = Colors.red; // Error color

    return Scheme(
      brightness: Brightness.dark,
      primary: const Color(0xFF007ACC),
      // Primary blue
      onPrimary: lightTextColor,
      primaryContainer: const Color(0xFF003366),
      // Primary container background color
      onPrimaryContainer: lightTextColor,
      secondary: const Color(0xFFFF9900),
      // Secondary color
      onSecondary: darkBackgroundColor,
      secondaryContainer: const Color(0xFFCC6600),
      // Secondary container background color
      onSecondaryContainer: lightTextColor,
      tertiary: const Color(0xFF00CC66),
      // Tertiary color
      onTertiary: darkBackgroundColor,
      tertiaryContainer: const Color(0xFF006633),
      // Tertiary container background color
      onTertiaryContainer: lightTextColor,
      error: errorColor,
      onError: darkBackgroundColor,
      errorContainer: const Color(0xFF660000),
      // Error container background color
      onErrorContainer: lightTextColor,
      outline: const Color(0xFF999999),
      // Border color
      outlineVariant: const Color(0xFF666666),
      // Border color variant
      background: darkBackgroundColor,
      onBackground: lightTextColor,
      surface: darkBackgroundColor,
      onSurface: lightTextColor,
      surfaceVariant: const Color(0xFF111111),
      // Surface color variant
      onSurfaceVariant: lightTextColor,
      // Text on dark surface variant
      inverseSurface: darkTextColor,
      // Text on inverse surface
      onInverseSurface: darkBackgroundColor,
      // Background on inverse surface
      inversePrimary: darkBackgroundColor,
      // Inverse primary background
      shadow: const Color(0x66000000),
      // Shadow (used with transparency)
      scrim: const Color(0x99000000)
          .withAlpha(255), // Scrim (used with transparency)
    );
  }
}
