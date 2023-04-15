import 'dart:async';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:injectable/injectable.dart';
import 'package:universal_platform/universal_platform.dart';

import '../core/core_file.dart';

bool get isMobile => UniversalPlatform.isIOS || UniversalPlatform.isAndroid;
bool get isAndroid => UniversalPlatform.isAndroid;
bool get isIOS => UniversalPlatform.isIOS;

@injectable
class DeviceService {
  Future<void> copy(String text) => FlutterClipboard.copy(text);

  bool get isAndroid => UniversalPlatform.isAndroid;

  Future<void> setStatusBar({Color? color}) async {
    await FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    await FlutterStatusbarcolor.setStatusBarColor(color ?? Colors.transparent);
  }

  Future<void> statusbar(bool isDark) async {
    await FlutterStatusbarcolor.setStatusBarWhiteForeground(isDark);
  }

  Future<void> updateNavigationBarColors(bool isDark,
      [Color buttombarColor = const Color(0xFF232323)]) async {
    if (isDark) {
      await FlutterStatusbarcolor.setNavigationBarColor(buttombarColor);
      await FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
    } else {
      await FlutterStatusbarcolor.setNavigationBarColor(Colors.white);
      await FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
    }
  }

  dynamic readFile(String path) => getFile(path);
}
