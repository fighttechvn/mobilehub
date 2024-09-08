//@GeneratedMicroModule;GenaralSettingPackageModule;package:genaral_setting/src/dependency_injection/genaral_setting_micro.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:genaral_setting/src/device_setting/dark_mode_setting/viewmodel/dark_mode_viewmodel.dart'
    as _i247;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

class GenaralSettingPackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.factory<_i247.DarkModeSettingViewModel>(
        () => _i247.DarkModeSettingViewModel(gh<_i460.SharedPreferences>()));
  }
}
