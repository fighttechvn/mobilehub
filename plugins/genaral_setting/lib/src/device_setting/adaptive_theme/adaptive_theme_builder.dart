import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

import '../dark_mode_setting/dark_mode_ui_state/device_setting_type.dart';

class AdaptiveThemeBuilder extends StatelessWidget {
  const AdaptiveThemeBuilder({
    super.key,
    required this.builder,
  });

  final Widget Function(DeviceModeSettingsType type) builder;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: AdaptiveTheme.of(context).modeChangeNotifier,
      builder: (_, mode, child) {
        var type = DeviceModeSettingsType.deviceSetting;

        if (mode.isDark) {
          type = DeviceModeSettingsType.dark;
        } else if (mode.isLight) {
          type = DeviceModeSettingsType.light;
        }

        return builder(type);
      },
    );
  }
}
