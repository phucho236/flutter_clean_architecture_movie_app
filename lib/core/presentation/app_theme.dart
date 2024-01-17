import 'package:flutter/material.dart';

class AppTheme {
  static get lightTheme => ThemeData(
        //Theme of text field
        inputDecorationTheme: const InputDecorationTheme(
            hintStyle: TextStyle(color: Colors.blue),
            border: InputBorder.none,

            //height of text field
            contentPadding: EdgeInsets.all(15)),
        //
        textTheme: const TextTheme(
          bodySmall: TextStyle(color: Colors.white),
          //Default of Text() if you dont create any value flutter will use this
          bodyMedium: TextStyle(height: 1, color: Colors.green),
          //
          bodyLarge: TextStyle(color: Colors.white),
          displaySmall: TextStyle(color: Colors.white),
          displayMedium: TextStyle(color: Colors.white),
          displayLarge: TextStyle(color: Colors.white),
          labelLarge: TextStyle(color: Colors.white),
          labelMedium: TextStyle(color: Colors.white),
          labelSmall: TextStyle(color: Colors.white),
          titleSmall: TextStyle(color: Colors.white),
          //Style input text of text field
          titleMedium: TextStyle(color: Colors.orange),
          //
          titleLarge: TextStyle(color: Colors.white),
          headlineSmall: TextStyle(color: Colors.white),
          headlineMedium: TextStyle(color: Colors.white),
          headlineLarge: TextStyle(color: Colors.white),
        ),
      );
}
