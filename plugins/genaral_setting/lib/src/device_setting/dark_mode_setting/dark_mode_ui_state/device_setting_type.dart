import 'package:flutter/material.dart';

enum DeviceModeSettingsType {
  deviceSetting,
  dark,
  light,
}

extension DeviceModeSettingsTypeExt on DeviceModeSettingsType {
  String title(BuildContext context) {
    switch (this) {
      case DeviceModeSettingsType.deviceSetting:
        return 'Device settings';
      case DeviceModeSettingsType.dark:
        return 'Dark mode';
      case DeviceModeSettingsType.light:
        return 'Light mode';
    }
  }
}
