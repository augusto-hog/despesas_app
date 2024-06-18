import 'package:flutter/material.dart';

final defaultTheme = ThemeData(
  inputDecorationTheme: const InputDecorationTheme(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
      ),
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
    ),
  ),
);
