import 'package:flutter/material.dart';

import '../adaptive_theme/adaptive_theme_builder.dart';
import '../dark_mode_setting/dark_mode_ui_state/device_setting_type.dart';
import '../device_setting_coodinator.dart';

class ThemeTextWidget extends StatelessWidget {
  const ThemeTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveThemeBuilder(
      builder: (type) {
        return ListTile(
          leading: const Text('Dark mode'),
          trailing: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              context.startDarkModeSetting(appName: 'App');
            },
            child: Text(type.title(context)),
          ),
        );
      },
    );
  }
}
