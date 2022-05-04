import 'package:flutter/material.dart';
import 'package:ml_app/theme/theme.dart';

class FlutterMLTheme {
  static ThemeData get light {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      bottomAppBarColor: Colors.transparent,
      bottomAppBarTheme: const BottomAppBarTheme(elevation: 0),
      colorScheme: ColorScheme.fromSwatch(
        accentColor: const Color.fromRGBO(87, 227, 167, 1),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
      toggleableActiveColor: const Color.fromRGBO(87, 227, 167, 1),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        color: Color.fromRGBO(87, 227, 167, 1),
      ),
      colorScheme: ColorScheme.fromSwatch(
        brightness: Brightness.dark,
        accentColor: const Color.fromRGBO(87, 227, 167, 1),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
      toggleableActiveColor: const Color.fromRGBO(87, 227, 167, 1),
    );
  }
}

class Background extends StatelessWidget {
  const Background({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.15, 1],
          colors: [
            Color.fromRGBO(63, 66, 94, 1),
            Color.fromRGBO(33, 37, 58, 1),
          ],
        ),
      ),
    );
  }
}
