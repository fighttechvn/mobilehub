import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

export 'package:permission_handler/permission_handler.dart';

class PermissionService {
  PermissionService._();

  static Future<bool> _requestPermission(Permission ps,
      [bool openSetting = true]) async {
    var status = await ps.status;
    if (status.isDenied) {
      status = await ps.request();
    }

    if ((Platform.isAndroid && status.isPermanentlyDenied) ||
        (Platform.isIOS && (status.isDenied || status.isPermanentlyDenied))) {
      if (openSetting) {
        await openAppSettings();
      }
      return false;
    }

    return !status.isDenied && !status.isPermanentlyDenied;
  }

  static Future<void> openSetting() async {
    await openAppSettings();
  }

  //////////////////////////////////////////////////////////////////
  ///                         Publish api                        ///
  //////////////////////////////////////////////////////////////////

  static Future<bool> checkPermission(
    Permission ps,
  ) async {
    final status = await ps.status;
    if (kDebugMode) {
      print('[app_core] $ps  status $status');
    }
    return !status.isDenied &&
        !status.isPermanentlyDenied &&
        !status.isRestricted;
  }

  static Future<bool> requestPermission(Permission ps,
      [bool openSetting = true]) async {
    var isGranted = await checkPermission(
      ps,
    );
    if (!isGranted) {
      isGranted = await _requestPermission(ps, openSetting);
    }
    return isGranted;
  }

  static Future<List<bool>> requestPermissions(
    List<Permission> pss,
  ) async {
    final result = <bool>[];
    for (final ps in pss) {
      result.add(await requestPermission(
        ps,
      ));
    }
    return result;
  }

  static Future<bool> checkGallery() async =>
      checkPermission(Permission.photos);
  static Future<bool> askGallery({bool openSetting = false}) async =>
      requestPermission(Permission.photos, false);

  static Future<bool> checkCamera() async => checkPermission(Permission.camera);
  static Future<bool> askCamera({bool openSetting = false}) async =>
      requestPermission(Permission.camera, false);

  static Future<bool> checkContacts() async =>
      await checkPermission(Permission.contacts);

  static Future<bool> askContacts({bool openSetting = false}) async =>
      requestPermission(Permission.contacts, false);
}
