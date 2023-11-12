import 'package:flutter/material.dart';

import 'image_gallery_widget.dart';

extension ImageGalleryCoodinator on BuildContext {
  void openImageGallery({
    required List<String> images,
    int forcusIndex = 0,
    String? heroTag,
    bool rootNavigator = false,
  }) {
    Navigator.of(this, rootNavigator: rootNavigator).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.transparent,
        barrierDismissible: true,
        pageBuilder: (c, a1, a2) => Material(
          color: Colors.transparent,
          child: ImageGalleryWidget(
            images: images,
            forcusIndex: forcusIndex,
            heroTag: heroTag,
          ),
        ),
        transitionsBuilder: (c, anim, a2, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 200),
      ),
    );
  }
}
