import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);

  ColorScheme get colorScheme => theme.colorScheme;

  TextTheme get textTheme => theme.textTheme;

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  NavigatorState get navigator => Navigator.of(this);

  Map<String, dynamic> get routeArguments {
    return ModalRoute.of(this)?.settings.arguments as Map<String, dynamic>;
  }
}
