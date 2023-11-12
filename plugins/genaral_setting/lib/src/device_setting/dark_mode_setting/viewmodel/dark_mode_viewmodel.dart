// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:value_notifier_saved/value_notifier_saved.dart';

import '../dark_mode_ui_state/device_setting_type.dart';

@injectable
class DarkModeSettingViewModel extends ChangeNotifier {
  final SharedPreferences _sharedPreferences;

  DarkModeSettingViewModel(this._sharedPreferences);

  late final ValueNotifierSaved<int> _darkModeCtr = ValueNotifierSaved<int>(
    '_keyDarkModeSetting',
    _sharedPreferences,
    defaultValue: 0,
  );

  DeviceModeSettingsType get selected =>
      DeviceModeSettingsType.values[_darkModeCtr.controller.value];

  void onSelected(DeviceModeSettingsType? type) {
    _darkModeCtr.controller.value = type?.index ?? 0;

    notifyListeners();
  }
}
