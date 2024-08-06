import 'package:flutter/material.dart';

extension BuildContextCoodinator on BuildContext {
  BuildContext get context => this;
}

extension BuildContextExt on BuildContext {
  bool isRouteNamed(String routeNamed) {
    final currentName = ModalRoute.of(this)?.settings.name;
    return routeNamed == currentName;
  }

  String? get currentName => ModalRoute.of(this)?.settings.name;

  void pop<T extends Object?>([T? result]) => Navigator.of(this).pop(result);
}

extension BuildContextThemeExt on BuildContext {
  TextTheme get textTheme => theme.textTheme;

  ThemeData get theme => Theme.of(this);

  bool get isDarkMode =>
      MediaQuery.of(this).platformBrightness == Brightness.dark;

  MediaQueryData get mediaData => MediaQuery.of(context);

  double get textScaleFactor => MediaQuery.textScalerOf(this).scale(1) / 1;

  bool get isScaleBig => textScaleFactor > 1.2;

  bool get isSmallDevice => MediaQuery.sizeOf(context).width < 400;
}
