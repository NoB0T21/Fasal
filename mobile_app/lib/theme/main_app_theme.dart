import 'package:flutter/material.dart';
import 'package:mobile_app/theme/appbar_theme.dart';

final lightcolorScheme = ColorScheme.fromSeed(
  seedColor: Color.fromRGBO(0, 201, 81, 1),
  brightness: Brightness.light,
);
final darkcolorScheme = ColorScheme.fromSeed(
  seedColor: Color.fromRGBO(4, 201, 81, 1),
  brightness: Brightness.dark,
);

class MainAppTheme {
  static ThemeData lightTheme () {
    return ThemeData(
      colorScheme: lightcolorScheme,
      appBarTheme: AppbarThemes.appBarTheme(lightcolorScheme.onSurface),
      useMaterial3: true
    );
  }

  static ThemeData darkTheme () {
    return ThemeData(
      colorScheme: darkcolorScheme,
      appBarTheme: AppbarThemes.appBarTheme(darkcolorScheme.onSurface),
      useMaterial3: true
    );
  }
}