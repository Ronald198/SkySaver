import 'package:flutter/material.dart';

class SkySaverPalette {
  static const MaterialColor mainColor = MaterialColor(
    0xFF6764C9, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xff5d5ab5), //10%
      100: Color(0xFF5250a1), //20%
      200: Color(0xFF48468d), //30%
      300: Color(0xFF3e3c79), //40%
      400: Color(0xFF343265), //50%
      500: Color(0xFF292850), //60%
      600: Color(0xFF1f1e3c), //70%
      700: Color(0xFF151428), //80%
      800: Color(0xFF0a0a14), //90%
      900: Color(0xFF000000), //100%
    },
  );
  // static const Color backgroundColor = Color.fromRGBO(163, 194, 164, 1);
}
