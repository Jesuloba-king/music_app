import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  fontFamily: "Suse",
  useMaterial3: true,
  colorScheme: ColorScheme.light(
      surface: Colors.grey.shade300,
      primary: Colors.grey.shade500,
      secondary: Colors.grey.shade200,
      inversePrimary: Colors.grey.shade900),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  fontFamily: "Suse",
  useMaterial3: true,
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade900,
    //  const Color.fromARGB(255, 24, 24, 24),
    primary: Colors.grey.shade600,
    // const Color.fromARGB(255, 34, 34, 34),
    secondary: const Color.fromARGB(255, 51, 51, 51),
    inversePrimary: Colors.grey.shade300,
  ),
);
