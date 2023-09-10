//@GeneratedMicroModule;GenaralSettingPackageModule;package:genaral_setting/src/dependency_injection/genaral_setting_micro.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i2;

import 'package:genaral_setting/src/device_setting/dark_mode_setting/viewmodel/dark_mode_viewmodel.dart'
    as _i3;
import 'package:injectable/injectable.dart' as _i1;
import 'package:shared_preferences/shared_preferences.dart' as _i4;

class GenaralSettingPackageModule extends _i1.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i2.FutureOr<void> init(_i1.GetItHelper gh) {
    gh.factory<_i3.DarkModeSettingViewModel>(
        () => _i3.DarkModeSettingViewModel(gh<_i4.SharedPreferences>()));
  }
}
