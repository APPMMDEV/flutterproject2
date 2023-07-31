import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.grey,
      
      elevation: 20.0,
      type: BottomNavigationBarType.fixed,
    ),
    colorScheme: const ColorScheme.light(
        background: Colors.transparent,
        onBackground: Colors.white,
        primary: Colors.white,
        onPrimary: Colors.black,
        secondary: Colors.black,
        onSecondary: Colors.blueGrey)

        // background: Colors.transparent,
        // primary: Colors.blueGrey,
        // onPrimary: Color.fromARGB(255, 138, 67, 0),
        // secondary: Colors.white,
        // onSecondary: Colors.black)
        
        );
