import 'dart:async';

import 'package:easy_file/easy_file.dart';
import 'package:flutter/material.dart';

abstract class DeviceService {
  Future<void> copy(String text);

  Future<void> setStatusBar({Color? color});

  Future<void> statusbar(bool isDark);

  Future<void> updateNavigationBarColors(
    bool isDark, [
    Color buttombarColor = const Color(0xFF232323),
  ]);

  dynamic readFile(String path) => getFile(path);

  ///
  /// loadString('packages/aiimi_data/assets/raw/onboarding.json')
  ///
  Future<String> loadString(String path);
}
