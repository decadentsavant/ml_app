import 'package:flutter/material.dart';

abstract class MLColors {
  static const primaryColor = Color.fromRGBO(87, 227, 167, 1);
  static const primaryShadeLight1 = Color.fromRGBO(183, 249, 220, 1);
  static const primaryShadeLight2 = Color.fromRGBO(129, 239, 192, 1);
  static const primaryShadeDark1 = Color.fromRGBO(52, 213, 144, 1);
  static const primaryShadeDark2 = Color.fromRGBO(19, 194, 119, 1);
  static const secondaryColor = Color.fromRGBO(130, 104, 227, 1);
  static const secondaryShadeLight1 = Color.fromRGBO(203, 191, 249, 1);
  static const secondaryShadeLight2 = Color.fromRGBO(162, 142, 239, 1);
  static const secondaryShadeDark1 = Color.fromRGBO(101, 71, 213, 1);
  static const secondaryShadeDark2 = Color.fromRGBO(72, 40, 195, 1);
  static const tertiaryColor = Color.fromRGBO(255, 226, 98, 1);
  static const tertiaryShadeLight1 = Color.fromRGBO(255, 243, 187, 1);
  static const tertiaryShadeLight2 = Color.fromRGBO(255, 234, 138, 1);
  static const tertiaryShadeDark1 = Color.fromRGBO(255, 220, 63, 1);
  static const tertiaryShadeDark2 = Color.fromRGBO(255, 213, 25, 1);
  static const errorColor = Color.fromRGBO(255, 142, 98, 1);
  static const errorShadeLight1 = Color.fromRGBO(255, 207, 187, 1);
  static const errorShadeLight2 = Color.fromRGBO(255, 171, 138, 1);
  static const errorShadeDark1 = Color.fromRGBO(255, 117, 63, 1);
  static const errorShadeDark2 = Color.fromRGBO(255, 90, 25, 1);
}

abstract class MLPadding {
  static const defaultWidget =
      EdgeInsets.symmetric(horizontal: 12, vertical: 10);
  static const heatMapContainer = Padding(padding: EdgeInsets.all(1));
}

abstract class MLElevation {
  static const none = 0.0;
  static const low = 1.0;
  static const high = 10.0;
}

class FlutterMLTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: MLColors.primaryColor,
        primary: MLColors.primaryColor,
        secondary: MLColors.secondaryColor,
        tertiary: MLColors.tertiaryColor,
        error: MLColors.errorColor,
      ),
      scaffoldBackgroundColor: Colors.transparent,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: MLElevation.none,
      ),
      bottomAppBarColor: Colors.transparent,
      bottomAppBarTheme: const BottomAppBarTheme(elevation: MLElevation.none),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: MLColors.primaryColor,
        foregroundColor: Colors.white,
        elevation: MLElevation.none,
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
      toggleableActiveColor: MLColors.secondaryColor,
      dividerColor: Colors.transparent,
    );
  }

  static ThemeData get dark {
    return ThemeData();
  }
}
