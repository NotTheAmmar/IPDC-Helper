import 'package:flutter/material.dart';

final ColorScheme _lightScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFFF96464),
);
final ColorScheme _darkScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFFF96464),
  brightness: Brightness.dark,
);

const CardTheme _cardTheme = CardTheme(
  shape: BeveledRectangleBorder(borderRadius: BorderRadius.zero),
);

final DividerThemeData _lightDivider = DividerThemeData(
  color: _lightScheme.secondary,
  indent: 10,
  endIndent: 10,
  thickness: 0.625,
);
final DividerThemeData _darkDivider = DividerThemeData(
  color: _darkScheme.secondary,
  indent: 10,
  endIndent: 10,
  thickness: 0.625,
);

final FilledButtonThemeData _filledButtonTheme = FilledButtonThemeData(
  style: ButtonStyle(
    shape: MaterialStateProperty.all(RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    )),
  ),
);

const TextTheme _textTheme = TextTheme(
  bodySmall: TextStyle(fontSize: 14),
  bodyMedium: TextStyle(fontSize: 16),
  bodyLarge: TextStyle(fontSize: 18),
  titleMedium: TextStyle(fontSize: 22),
  titleLarge: TextStyle(fontSize: 24),
  titleSmall: TextStyle(fontSize: 20),
);

final ThemeData lightTheme = ThemeData(
  colorScheme: _lightScheme,
  appBarTheme: AppBarTheme(
    backgroundColor: _lightScheme.inversePrimary,
    titleTextStyle: _textTheme.titleLarge?.copyWith(
      color: _lightScheme.onBackground,
    ),
  ),
  cardTheme: _cardTheme,
  dividerTheme: _lightDivider,
  filledButtonTheme: _filledButtonTheme,
  textTheme: _textTheme,
  useMaterial3: true,
);
final ThemeData darkTheme = ThemeData(
  colorScheme: _darkScheme,
  appBarTheme: AppBarTheme(
    backgroundColor: _darkScheme.inversePrimary,
    titleTextStyle: _textTheme.titleLarge?.copyWith(
      color: _darkScheme.onBackground,
    ),
  ),
  cardTheme: _cardTheme,
  dividerTheme: _darkDivider,
  filledButtonTheme: _filledButtonTheme,
  textTheme: _textTheme,
  useMaterial3: true,
);
