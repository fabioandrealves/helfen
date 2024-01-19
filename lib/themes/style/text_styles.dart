import 'package:flutter/material.dart';

class TextStyles {
  static TextStyle textLightOnSurface(
          {required double fontSize,
          required FontWeight fontWeight,
          required color}) =>
      TextStyle(
          fontSize: fontSize,
          letterSpacing: 0,
          color: color,
          fontWeight: fontWeight);

  static TextStyle textDarkOnSurface(
          {required double fontSize,
          required FontWeight fontWeight,
          required color}) =>
      TextStyle(
          fontSize: fontSize,
          letterSpacing: 0,
          color: color,
          fontWeight: fontWeight);

  // static TextStyle textLightOnSurfaceBold(
  //     {required double fontSize, required color}) =>
  //     TextStyle(fontSize: fontSize, letterSpacing: 0, color: color, fontWeight: FontWeight.bold.);
  //
  // static TextStyle textDarkOnSurfaceBold(
  //     {required double fontSize, required color}) =>
  //     TextStyle(fontSize: fontSize, letterSpacing: 0, color: color);

  //static TextStyle textDarkOnBackground({required double fontSize, required colo}) => TextStyle(fontSize: fontSize, )

// static TextStyle _textStyleOnSurface(BuildContext context,
//     ThemeProvider themeProvider) {
//   final scheme = getScheme(context, false);
//
//   return TextStyle(
//     letterSpacing: 0,
//     fontSize: fontSize, // Aqui, você pode usar o valor inicializado
//     color: themeProvider.isDarkMode
//         ? Color(scheme.onSurface)
//         : Color(scheme.onSurface),
//   );
// }
//
// TextStyle _textStyleOnBackground(BuildContext context,
//     ThemeProvider themeProvider) {
//   final scheme = getScheme(context, false);
//
//   return TextStyle(
//       letterSpacing: 0,
//       fontSize: fontSize, // Aqui, você pode usar o valor inicializado
//       color: themeProvider.isDarkMode
//           ? Color(scheme.onBackground)
//           : Color(scheme.onBackground));
// }
}
