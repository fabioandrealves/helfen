import 'package:flutter/material.dart';
import 'package:helfen_bus/themes/color/scheme.dart';

import '../infra/provider/theme_provider.dart';

class AppThemes {
  final ThemeProvider themeProvider;
  final Color seedColor;

  AppThemes({
    required this.themeProvider,
    required this.seedColor,
  });

  ThemeData getTheme(BuildContext context) {
    final isDarkMode = themeProvider.isDarkMode;
    final colorScheme = getColorScheme(context, isDarkMode);

    return ThemeData.from(colorScheme: colorScheme);
  }

  Scheme getScheme(BuildContext context) =>
      _getScheme(context, themeProvider.isDarkMode);

  ColorScheme getColorScheme(BuildContext context, bool isDarkMode) {
    final scheme = _getScheme(context, isDarkMode);

    return ColorScheme.fromSeed(
      seedColor: scheme.primary,
      brightness: scheme.brightness,
      primary: scheme.primaryContainer,
      onPrimary: scheme.onPrimaryContainer,
      secondary: scheme.secondary,
      onSecondary: scheme.onSecondary,
      tertiary: scheme.tertiary,
      onTertiary: scheme.onTertiary,
      error: scheme.error,
      onError: scheme.onError,
      outline: scheme.outline,
      outlineVariant: scheme.outlineVariant,
      background: scheme.background,
      onBackground: scheme.onBackground,
      surface: scheme.surface,
      onSurface: scheme.onSurface,
      surfaceVariant: scheme.surfaceVariant,
      onSurfaceVariant: scheme.onSurfaceVariant,
      inverseSurface: scheme.inverseSurface,
      onInverseSurface: scheme.onInverseSurface,
      inversePrimary: scheme.inversePrimary,
      shadow: scheme.shadow,
      scrim: scheme.scrim,
    );
  }

  Scheme _getScheme(BuildContext context, bool isDarkMode) {
    final brightness = isDarkMode ? Brightness.dark : Brightness.light;
    return brightness == Brightness.dark
        ? Scheme.dark(seedColor, brightness)
        : Scheme.light(seedColor, brightness);
  }
}
