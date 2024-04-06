import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:imagewidget/imagewidget.dart';

import '../video_control/video_control_custom_widget.dart';
import 'loading_media_widget.dart';
import 'video_widget.dart';

const _kAspecRatio = 414 / 260;

class VideoPostWidget extends StatefulWidget {
  final ImageInfoData video;
  final String? thumnailUrl;
  final bool isLoading;
  final String? title;
  final double aspecRatio;
  final Function(ImageInfoData)? onTapRemove;
  final bool onlyPlayFullscreen;
  final bool controlBarAvailable;
  final void Function(VideoPlayerController controller)? onLoaded;
  final bool playCenter;
  final bool autoPlay;
  final bool showFullController;
  final Widget? iconPlayCenterForOnlyPlayFullScreen;
  final ControllerWidgetItem? controllerWidget;
  final void Function()? onTapCustom;
  final Color? playColor;
  final bool isVideo;
  final bool isMute;

  const VideoPostWidget({
    Key? key,
    required this.video,
    this.isLoading = false,
    this.onTapRemove,
    this.title,
    this.aspecRatio = _kAspecRatio,
    this.thumnailUrl,
    this.onlyPlayFullscreen = true,
    this.playCenter = false,
    this.controlBarAvailable = false,
    this.showFullController = true,
    this.onLoaded,
    this.autoPlay = false,
    this.iconPlayCenterForOnlyPlayFullScreen,
    this.controllerWidget,
    this.onTapCustom,
    this.playColor,
    this.isVideo = true,
    this.isMute = false,
  }) : super(key: key);

  @override
  State<VideoPostWidget> createState() => _VideoPostWidgetState();
}

class _VideoPostWidgetState extends State<VideoPostWidget> {
  @override
  Widget build(BuildContext context) {
    final isVideo = widget.isVideo ||
        ['mp4', 'mov'].contains(widget.video.url.split('.').last.toLowerCase());

    if (widget.video.url.isEmpty || isVideo == false) {
      return const SizedBox.shrink();
    }

    final showFullController = widget.showFullController;
    return AspectRatio(
      aspectRatio: widget.aspecRatio,
      child: Container(
        color: Colors.black,
        child: Stack(
          children: [
            VideoWidget(
              onLoaded: widget.onLoaded,
              isAutoPlay: widget.autoPlay,
              videoUrl: widget.video.url,
              thumnailUrl: widget.thumnailUrl,
              onlyPlayFullscreen: widget.onlyPlayFullscreen,
              controlBarAvailable: widget.controlBarAvailable,
              videoRatio: widget.aspecRatio,
              iconPlay: widget.iconPlayCenterForOnlyPlayFullScreen,
              isMute: widget.isMute,
              builderVideoControl: (
                VideoPlayerController videoPlayerController,
                void Function()? callbackFullScreen,
              ) {
                return VideoControlCustomWidget(
                  videoPlayerController: videoPlayerController,
                  onFullscreen: showFullController ? callbackFullScreen : null,
                  showPlayButton: showFullController,
                  showFastSeek: showFullController,
                  showProgressSlide: showFullController,
                  playCenter: widget.playCenter,
                  controllerWidget: widget.controllerWidget,
                  onTapCustom: widget.onTapCustom,
                  playColor: widget.playColor,
                );
              },
            ),
            Positioned(
              bottom: 0,
              child: IgnorePointer(
                ignoring: true,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.01),
                        Colors.black.withOpacity(0.25),
                        Colors.black.withOpacity(0.01),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
            ),
            if (widget.onTapRemove != null)
              Positioned(
                top: 5,
                right: 5,
                child: widget.isLoading != false
                    ? const LoadingMediaWidget()
                    : GestureDetector(
                        onTap: () => widget.onTapRemove!(widget.video),
                        child: Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            color: Colors.white60,
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: const Icon(
                            Icons.close,
                            size: 18,
                          ),
                        ),
                      ),
              ),
          ],
        ),
      ),
    );
  }
}
