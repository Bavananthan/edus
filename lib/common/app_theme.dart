import 'package:flutter/material.dart';

import '../provider/locator.dart';

ThemeData lightMode = ThemeData(
  fontFamily: 'verlag',
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Color.fromARGB(255, 255, 255, 255),
    primary: Color.fromARGB(255, 29, 177, 53),
    primaryContainer: Color.fromARGB(255, 253, 253, 253),
    secondary: Color.fromARGB(255, 24, 24, 39),
    secondaryContainer: Color.fromARGB(255, 39, 39, 53),
    onPrimary: colors.brandColor,
    onSecondary: colors.brandColor2,
  ),
);

ThemeData darkMode = ThemeData(
  fontFamily: 'verlag',
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: Color.fromARGB(255, 0, 0, 17),
    primary: Color.fromARGB(255, 79, 80, 78),
    primaryContainer: Color.fromARGB(255, 24, 24, 39),
    secondary: Color.fromARGB(255, 204, 204, 204),
    secondaryContainer: Color.fromARGB(255, 16, 230, 8),
    onPrimary: colors.shadow,
    onSecondary: colors.gray,
  ),
);
