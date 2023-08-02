import 'package:flutter/material.dart';

import '../Helper/ConstsData.dart';

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    appBarTheme:
        const AppBarTheme(backgroundColor: Colors.black54),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      selectedItemColor: Colors.yellow,
      unselectedItemColor: Colors.white70,
      elevation: 20.0,
      type: BottomNavigationBarType.fixed,
    ),
    colorScheme: ColorScheme.dark(
        background: Colors.transparent,
        onBackground: Colors.black87,
        primary: Colors.transparent,
        onPrimary: Colors.white,
        secondary: Colors.white,
        onSecondary: Colors.yellowAccent));



    // colorScheme: const ColorScheme.light(
    //     background: Colors.transparent,
    //     onBackground: Colors.white,
    //     primary: Colors.white,
    //     onPrimary: Colors.black,
    //     secondary: Colors.black,
    //     onSecondary: Colors.blueGrey)