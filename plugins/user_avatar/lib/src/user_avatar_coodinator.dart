import 'package:device_media/device_media.dart';
import 'package:easy_device_media/device_media.dart';
import 'package:flutter/material.dart';

import 'views/selector_resource_image_widget.dart';

typedef AvatarSelectorBuilder = Widget Function(
  void Function() onUseCamera,
  void Function() onUseGallery,
);

extension UserAvatarCoodinator on BuildContext {
  Future<T?> startUpdateAvatar<T>({
    AvatarSelectorBuilder? selectorBuilder,
    Widget? iconCamera,
    Widget? iconGallery,
    String? title,
    String? titleCamera,
    String? titleGallery,
  }) async {
    return _showModelUpdatePhoto<T?>(
      CropType.circle,
      selectorBuilder: (onUseCamera, onUseGallery) {
        if (selectorBuilder != null) {
          return selectorBuilder(onUseCamera, onUseGallery);
        }

        return SelectResourceImageWidget(
          onUseCamera: onUseCamera,
          onUseGallery: onUseGallery,
          iconCamera: iconCamera,
          iconGallery: iconGallery,
          title: title,
          titleCamera: titleCamera,
          titleGallery: titleGallery,
        );
      },
    );
  }

  Future<T?> _showModelUpdatePhoto<T>(
    CropType type, {
    required AvatarSelectorBuilder selectorBuilder,
    bool useCrop = true,
  }) async {
    return showModalBottomSheet<T?>(
      context: this,
      barrierColor: Colors.black26,
      backgroundColor: Colors.white,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return selectorBuilder(
          () {
            pickedImage(DeviceMediaSource.camera, needCrop: useCrop)
                .then((value) {
              if (mounted) {
                Navigator.of(context).pop(value);
              }
            });
          },
          () {
            pickedImage(
              DeviceMediaSource.gallery,
              needCrop: useCrop,
              cropType: type,
            ).then((value) {
              if (mounted) {
                Navigator.of(context).pop(value);
              }
            });
          },
        );
      },
    );
  }
}
