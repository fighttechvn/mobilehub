import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  bool isRouteNamed(String routeNamed) {
    final currentName = ModalRoute.of(this)?.settings.name;
    return routeNamed == currentName;
  }

  String? get currentName => ModalRoute.of(this)?.settings.name;
}

extension BuildContextThemeExt on BuildContext {
  TextTheme get textTheme => theme.textTheme;

  ThemeData get theme => Theme.of(this);

  bool get isDarkMode =>
      MediaQuery.of(this).platformBrightness == Brightness.dark;
}

extension ContextCoodinator on BuildContext {
  BuildContext get context => this;

  void pop() => Navigator.of(this).pop();
}
