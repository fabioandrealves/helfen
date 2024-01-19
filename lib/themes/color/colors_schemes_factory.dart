import 'package:flutter/material.dart';
import 'package:helfen_bus/themes/color/scheme.dart';

class ColorSchemeFactory {
  static ColorScheme fromSeed({
    required Color seedColor,
    Brightness brightness = Brightness.light,
    Color? primary,
    Color? onPrimary,
    Color? primaryContainer,
    Color? onPrimaryContainer,
    Color? secondary,
    Color? onSecondary,
    Color? secondaryContainer,
    Color? onSecondaryContainer,
    Color? tertiary,
    Color? onTertiary,
    Color? tertiaryContainer,
    Color? onTertiaryContainer,
    Color? error,
    Color? onError,
    Color? errorContainer,
    Color? onErrorContainer,
    Color? outline,
    Color? outlineVariant,
    Color? background,
    Color? onBackground,
    Color? surface,
    Color? onSurface,
    Color? surfaceVariant,
    Color? onSurfaceVariant,
    Color? inverseSurface,
    Color? onInverseSurface,
    Color? inversePrimary,
    Color? shadow,
    Color? scrim,
    Color? surfaceTint,
  }) {
    final Scheme scheme;
    switch (brightness) {
      case Brightness.light:
        scheme = Scheme.light(seedColor, Brightness.light);
        break;
      case Brightness.dark:
        scheme = Scheme.dark(seedColor, Brightness.dark);
        break;
    }
    return ColorScheme(
      primary: primary ?? scheme.primary,
      onPrimary: onPrimary ?? scheme.onPrimary,
      primaryContainer: primaryContainer ?? scheme.primaryContainer,
      onPrimaryContainer: onPrimaryContainer ?? scheme.onPrimaryContainer,
      secondary: secondary ?? scheme.secondary,
      onSecondary: onSecondary ?? scheme.onSecondary,
      secondaryContainer: secondaryContainer ?? scheme.secondaryContainer,
      onSecondaryContainer: onSecondaryContainer ?? scheme.onSecondaryContainer,
      tertiary: tertiary ?? scheme.tertiary,
      onTertiary: onTertiary ?? scheme.onTertiary,
      tertiaryContainer: tertiaryContainer ?? scheme.tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer ?? scheme.onTertiaryContainer,
      error: error ?? scheme.error,
      onError: onError ?? scheme.onError,
      errorContainer: errorContainer ?? scheme.errorContainer,
      onErrorContainer: onErrorContainer ?? scheme.onErrorContainer,
      outline: outline ?? scheme.outline,
      outlineVariant: outlineVariant ?? scheme.outlineVariant,
      background: background ?? scheme.background,
      onBackground: onBackground ?? scheme.onBackground,
      surface: surface ?? scheme.surface,
      onSurface: onSurface ?? scheme.onSurface,
      surfaceVariant: surfaceVariant ?? scheme.surfaceVariant,
      onSurfaceVariant: onSurfaceVariant ?? scheme.onSurfaceVariant,
      inverseSurface: inverseSurface ?? scheme.inverseSurface,
      onInverseSurface: onInverseSurface ?? scheme.onInverseSurface,
      inversePrimary: inversePrimary ?? scheme.inversePrimary,
      shadow: shadow ?? scheme.shadow,
      scrim: scrim ?? scheme.scrim,
      surfaceTint: surfaceTint ?? scheme.primary,
      brightness: brightness,
    );
  }
}
