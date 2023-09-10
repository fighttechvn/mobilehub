import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'dark_mode_setting/dark_mode_setting_screen.dart';
import 'dark_mode_setting/viewmodel/dark_mode_viewmodel.dart';

extension DeviceSettingCoodinator on BuildContext {
  Future<T?> startDarkModeSetting<T>({String? appName}) {
    //return Navigator.of(this).pushNamed(DarkModeSettingScreen.routeName);
    return Navigator.of(this).push(
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider<DarkModeSettingViewModel>(
          create: (context) => GetIt.instance.get(),
          child: DarkModeSettingScreen(
            appName: appName,
          ),
        ),
      ),
    );
  }
}
