import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  bool isRouteNamed(String routeNamed) {
    final currentName = ModalRoute.of(this)?.settings.name;
    return routeNamed == currentName;
  }

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  bool get isDarkMode =>
      MediaQuery.of(this).platformBrightness == Brightness.dark;
}
