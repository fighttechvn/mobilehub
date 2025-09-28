import 'package:easy_device_media/device_media.dart';
import 'package:easy_permission/easy_permission.dart';
import 'package:flutter/material.dart';
import 'package:imagewidget/imagewidget.dart';
import 'package:universal_platform/universal_platform.dart';

import '../l10n/l10n.dart';

extension DeviceImageExtension on BuildContext {
  Future<T?> pickedImage<T>(
    DeviceMediaSource source, {
    CropType cropType = CropType.circle,
    bool needCrop = false,
  }) async {
    return await DeviceMediaServiceImpl().openPickImage(
      source,
      needCompress: true,
      cropType: cropType,
      needCrop: needCrop,
    ) as T?;
  }

  Future<T?> pickPhoto<T>() async {
    return pickedImage<T?>(DeviceMediaSource.gallery);
  }

  Future<T?> takePhoto<T>() async {
    return pickedImage<T?>(DeviceMediaSource.camera);
  }

  Future<T?> showUpdateCover<T>() async {
    return showModelUpdatePhoto<T?>(CropType.rectangle);
  }

  Future<T?> showUpdateAvatar<T>() async {
    return showModelUpdatePhoto<T?>(CropType.circle);
  }

  void _onTapGallery({
    bool useCrop = false,
    CropType cropType = CropType.circle,
  }) {
    (UniversalPlatform.isIOS ? PermissionService.askGallery() : isYesDefault())
        .then(
      (value) {
        if (value == true) {
          pickedImage(
            DeviceMediaSource.gallery,
            needCrop: useCrop,
            cropType: cropType,
          ).then((value) => Navigator.of(this).pop(value));
        } else {
          Navigator.of(this).pop();
          startAlert(
            title: 'Notificaiton',
            content: 'Please grant permission in settings',
            text1: 'OK',
            text2: 'Go to Settings',
          ).then((value) {
            if (value == false) {
              PermissionService.openSetting();
            }
          });
        }
      },
    );
  }

  void _onTapCamera({
    bool useCrop = false,
    CropType cropType = CropType.circle,
  }) {
    PermissionService.askCamera().then(
      (value) {
        if (value == true) {
          pickedImage(
            DeviceMediaSource.camera,
            needCrop: useCrop,
            cropType: cropType,
          ).then((value) => Navigator.of(this).pop(value));
        } else {
          Navigator.of(this).pop();
          startAlert(
            title: 'Notificaiton',
            content: 'Please grant permission in settings',
            text1: 'OK',
            text2: 'Go to Settings',
          ).then((value) {
            if (value == false) {
              PermissionService.openSetting();
            }
          });
        }
      },
    );
  }

  Future<T?> showModelUpdatePhoto<T>(
    CropType type, {
    bool useCrop = true,
  }) async {
    return showModalBottomSheet<T?>(
      context: this,
      barrierColor: Colors.black.withValues(alpha: 0.25),
      backgroundColor: Colors.white,
      clipBehavior: Clip.none,
      builder: (BuildContext context) {
        return Container(
          color: Colors.white,
          padding: const EdgeInsets.only(top: 10),
          child: SafeArea(
            minimum: const EdgeInsets.only(bottom: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => _onTapGallery(useCrop: true),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const ImageWidget(
                          'assets/image.svg',
                          package: 'device_media',
                        ),
                        const SizedBox(width: 15),
                        Text(
                          DeviceMediaLocalizations.of(context).library,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff0C0C0C),
                                height: 1.56,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => _onTapCamera(useCrop: true),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const ImageWidget(
                          'assets/camera.svg',
                          package: 'device_media',
                        ),
                        const SizedBox(width: 15),
                        Text(
                          DeviceMediaLocalizations.of(context).camera,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff0C0C0C),
                                height: 1.56,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(thickness: 6, color: Color(0xffF5F5F5)),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: Navigator.of(context).pop,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DeviceMediaLocalizations.of(context).cancel,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                                height: 1.56,
                                color: const Color(0xff666666),
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
