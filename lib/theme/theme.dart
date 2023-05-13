import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    elevation: 0, // тень
    backgroundColor: Color.fromARGB(255, 29, 29, 26),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w800,
    ),
  ),
  primarySwatch: Colors.deepPurple,
  scaffoldBackgroundColor: const Color.fromARGB(255, 29, 29, 26),
  textTheme: TextTheme(
      headlineMedium: const TextStyle(
        color: Colors.white,
      ),
      bodyMedium: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 20,
      ),
      labelSmall: TextStyle(
        color: Colors.white.withOpacity(0.6),
        fontSize: 14,
      )),
  dividerColor: Colors.white38,
  listTileTheme: const ListTileThemeData(iconColor: Colors.white),
);
