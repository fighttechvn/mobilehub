import 'package:flutter/material.dart';
import 'package:imagewidget/imagewidget.dart';

import 'video/video_detail/video_detail.dart';
import 'video/video_widget/video_post_widget.dart';
import 'video/video_widget/video_widget.dart';
import 'widgets/template_screen_widget.dart';

extension VideoCoordinator on BuildContext {
  Future<T?> onTapDetailVideo<T>(
    String link, {
    Widget? player,
    bool isAutoPlay = false,
  }) {
    return Navigator.of(this).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.transparent,
        barrierDismissible: true,
        transitionsBuilder: (c, anim, a2, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (_, ___, context) => Material(
          color: Colors.transparent,
          child: DetailVideoWidget(
            player: player ??
                VideoWidget(
                  videoUrl: link,
                  isShowLoading: true,
                  isAutoPlay: isAutoPlay,
                ),
            heroTag: link,
            aspectRatio: 2,
          ),
        ),
      ),
    );
  }

  Future<T?> startVideoDetail<T>({
    required String url,
    String? title,
  }) {
    return Navigator.of(this).push(
      MaterialPageRoute(
        builder: (context) => TemplateScreenWidget(
          title: title,
          child: VideoPostWidget(
            video: ImageInfoData(
              url,
              null,
              null,
              'video',
            ),
            onlyPlayFullscreen: false,
            playCenter: false,
            controlBarAvailable: false,
            autoPlay: false,
            aspecRatio: 2,
          ),
        ),
      ),
    );
  }
}
