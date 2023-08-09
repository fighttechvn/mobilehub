import 'dart:async';

import 'package:clipboard/clipboard.dart';
import 'package:easy_file/easy_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:injectable/injectable.dart';

import '../../helpers/platform_helper.dart';
import '../device_service.dart';

@Injectable(as: DeviceService)
class DeviceServiceImpl extends DeviceService {
  PlatformUniversal get _platform => PlatformUniversal();

  @override
  bool get isAndroid => _platform.isAndroid;

  @override
  bool get isiOS => _platform.isIOS;

  @override
  Future<void> copy(String text) => FlutterClipboard.copy(text);

  @override
  Future<void> setStatusBar({Color? color}) async {
    if (isMobile) {
      await FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
      await FlutterStatusbarcolor.setStatusBarColor(
        color ?? Colors.transparent,
      );
    }
  }

  @override
  Future<void> statusbar(bool isDark) async {
    if (isMobile) {
      await FlutterStatusbarcolor.setStatusBarWhiteForeground(isDark);
    }
  }

  @override
  Future<void> updateNavigationBarColors(
    bool isDark, [
    Color buttombarColor = const Color(0xFF232323),
  ]) async {
    if (isMobile) {
      if (isDark) {
        await FlutterStatusbarcolor.setNavigationBarColor(buttombarColor);
        await FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
      } else {
        await FlutterStatusbarcolor.setNavigationBarColor(Colors.white);
        await FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
      }
    }
  }

  @override
  dynamic readFile(String path) => getFile(path);

  ///
  /// loadString('packages/aiimi_data/assets/raw/onboarding.json')
  ///
  @override
  Future<String> loadString(String path) async {
    return rootBundle.loadString(path);
  }
}
