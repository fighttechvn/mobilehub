import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

class AdaptiveThemeWidget extends StatelessWidget {
  const AdaptiveThemeWidget({
    super.key,
    required this.builder,
    required this.lightTheme,
    required this.darkTheme,
    required this.initial,
  });

  final Widget Function(
    BuildContext context,
    ThemeData theme,
    ThemeData darkTheme,
  ) builder;
  final ThemeData lightTheme;
  final ThemeData darkTheme;
  final String? initial;

  @override
  Widget build(BuildContext context) {
    var savedTheme = AdaptiveThemeMode.light;
    if (initial == AdaptiveThemeMode.dark.modeName) {
      savedTheme = AdaptiveThemeMode.dark;
    } else if (initial == AdaptiveThemeMode.system.modeName) {
      savedTheme = AdaptiveThemeMode.system;
    }
    return AdaptiveTheme(
      light: lightTheme,
      dark: darkTheme,
      initial: savedTheme,
      builder: (theme, darkTheme) {
        return builder(context, theme, darkTheme);
      },
    );
  }
}

Future<String?> initAdaptiveTheme() async {
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  return savedThemeMode?.modeName;
}
