import 'package:flutter/material.dart';

class FlutterMLTheme {
  static ThemeData get light {
    const _primaryColor = Color.fromRGBO(87, 227, 167, 1);
    const _secondaryColor = Color.fromRGBO(110, 108, 228, 1);
    const _tertiary = Color.fromRGBO(255, 216, 98, 1);
    const _complementColor = Color.fromRGBO(255, 142, 98, 1);
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _primaryColor,
        primary: _primaryColor,
        secondary: _secondaryColor,
        tertiary: _tertiary,
        error: _complementColor,
      ),
      scaffoldBackgroundColor: Colors.transparent,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      bottomAppBarColor: Colors.transparent,
      bottomAppBarTheme: const BottomAppBarTheme(elevation: 0),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: _primaryColor.withOpacity(1),
        foregroundColor: Colors.white,
        elevation: 300,
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
      toggleableActiveColor: _secondaryColor,
    );
  }

  static ThemeData get dark {
    return ThemeData();
  }
}
