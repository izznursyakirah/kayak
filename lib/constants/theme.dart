import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
  scaffoldBackgroundColor: const Color.fromRGBO(255, 255, 255, 1),
  primaryColor: Colors.grey[800] ,
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.blueGrey,
      textStyle: const TextStyle(
        color: Colors.blueGrey,
      ),
      side: const BorderSide(color: Colors.blueGrey, width: 1.7),
      disabledForegroundColor:Colors.blueGrey.withOpacity(0.38)
    )
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: outlineInputBorder,
    errorBorder: outlineInputBorder,
    enabledBorder: outlineInputBorder,
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,
    focusedBorder: outlineInputBorder,
    disabledBorder: outlineInputBorder,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blueGrey[800],
      textStyle: const TextStyle(
        fontSize: 18.0,
      ),
      disabledBackgroundColor: Colors.amber,
    ),
  ),
);

OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderSide: BorderSide(
  color: Colors.grey,
)
);
