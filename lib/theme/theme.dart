import 'package:flutter/material.dart';
import 'package:todolist/constants/constants.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(),
  scaffoldBackgroundColor: background,
  primaryColor: Color.fromRGBO(26, 115, 233, 1),
  secondaryHeaderColor: gray,
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(),
  scaffoldBackgroundColor: Color.fromRGBO(0, 0, 0, 1),
  appBarTheme: AppBarTheme(color: Color.fromRGBO(0, 0, 0, 1), foregroundColor: background),
  primaryColor: Color.fromRGBO(26, 115, 233, 1),

  secondaryHeaderColor: gray,
);
