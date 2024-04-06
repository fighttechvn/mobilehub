import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:imagewidget/imagewidget.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../video_constants.dart';
import '../player/single_player_manager.dart';
import '../player/video_state_manager.dart';
import '../video_detail/video_detail.dart';

typedef BuilderVideoControl = Widget Function(
  VideoPlayerController,
  void Function()? onTapFullScreen,
);

class VideoWidget extends StatefulWidget {
  final String videoUrl;
  final String? thumnailUrl;
  final String? tag;
  final bool isShowLoading;
  final bool isAutoPlay;
  final bool onlyPlayFullscreen;
  final bool controlBarAvailable;
  final BuilderVideoControl? builderVideoControl;
  final void Function(VideoPlayerController controller)? onLoaded;
  final double videoRatio;
  final GestureLongPressCallback? onLongPress;
  final bool isMute;
  final Widget? iconPlay;

  //the flag set is `true` that video don't care about `VideoPlayerStateManager`
  final bool forceState;

  const VideoWidget({
    super.key,
    required this.videoUrl,
    this.tag,
    this.isShowLoading = false,
    this.isAutoPlay = false,
    this.onlyPlayFullscreen = true,
    this.controlBarAvailable = true,
    this.thumnailUrl,
    this.builderVideoControl,
    this.onLoaded,
    this.videoRatio = 375 / 243,
    this.onLongPress,
    this.isMute = false,
    this.forceState = false,
    this.iconPlay,
  });

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget>
    with SinglePlayerPlayingMixin, VideoPlayerStateManagerMixin {
  final iconPlayNotifier = ValueNotifier(false);
  VideoPlayerController? videoPlayerController;
  CustomVideoPlayerController? _customVideoPlayerController;
  final _globalKey = GlobalKey();

  bool _isMuteStateChanged = false;

  @override
  bool isPlaying(ChangeNotifier controller) {
    return (controller as VideoPlayerController).value.isPlaying;
  }

  @override
  FutureOr pause(ChangeNotifier controller) {
    final c = controller as VideoPlayerController;
    if (c.value.isPlaying) {
      c.pause();
    }
  }

  @override
  ChangeNotifier registerPlayer(BuildContext context) {
    return videoPlayerController!;
  }

  @override
  void onVideoStateChange(VideoPlayerState state) {
    if (!widget.forceState) {
      if (videoPlayerController != null && mounted) {
        _isMuteStateChanged = true;
        videoPlayerController?.setVolume(state.isMute ? 0 : 1);
      }
    }
  }

  void syncMuteState() {
    // this case happen when initial load
    if (widget.isMute && !_isMuteStateChanged) {
      // force mute from widget tree but the mute state not changed yet
      videoPlayerController?.setVolume(0);
    } else if (!widget.forceState) {
      // state mute or not by state manager
      videoPlayerController?.setVolume(!isMute ? 1 : 0);
    }
  }

  void _play() {
    syncMuteState();

    videoPlayerController?.play();
  }

  @override
  void initState() {
    if (enableLogVideoDebug) {
      log('[VideoWidget] url: ${widget.videoUrl}');
    }

    videoPlayerController = widget.videoUrl.contains('http')
        ? VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
        : VideoPlayerController.file(File(widget.videoUrl));

    videoPlayerController!.initialize().then((value) {
      setState(() {});
      widget.onLoaded?.call(videoPlayerController!);
    });

    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: videoPlayerController!,
      customVideoPlayerSettings: CustomVideoPlayerSettings(
        // deviceOrientationsAfterFullscreen: ,
        controlBarAvailable: widget.controlBarAvailable,
        showPlayButton: true,
        showFullscreenButton: true,
        thumbnailWidget: (widget.thumnailUrl?.isNotEmpty ?? false)
            ? ImageWidget(
                widget.thumnailUrl!,
                package: kPackageMedia,
              )
            : null,
        controlBarDecoration:
            BoxDecoration(color: Colors.black.withOpacity(0.3)),
        controlBarPadding: const EdgeInsets.all(0),
        controlsPadding: const EdgeInsets.all(4),
        settingsButtonAvailable: false,
      ),
    );
    setMute(widget.isMute);
    super.initState();
  }

  @override
  void dispose() {
    if (enableLogVideoDebug) {
      log('[VideoWidget] dispose url: ${widget.videoUrl}');
    }

    _customVideoPlayerController?.dispose();
    videoPlayerController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;

    final player = CustomVideoPlayer(
      customVideoPlayerController: _customVideoPlayerController!,
    );

    final videoWidget = VisibilityDetector(
      key: _globalKey,
      onVisibilityChanged: (info) {
        if (info.visibleFraction < 0.2) {
          videoPlayerController?.pause();
          return;
        }

        if (info.visibleFraction >= 0.7 &&
            videoPlayerController?.value.isPlaying == false) {
          // Case initial load the parent do not allow auto play but we must to
          // sync mute state
          if (!widget.isAutoPlay) {
            syncMuteState();
            return;
          }

          // Case need to auto play
          final box = context.findRenderObject() as RenderBox;
          final pos = box.globalToLocal(Offset.zero);
          final position = Offset(-pos.dx, -pos.dy);

          final startPost = size.height / 4;
          final endPost = size.height / 2 + box.size.height;

          if (position.dy > startPost && position.dy < endPost) {
            _play();
          }
        }
      },
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          if (widget.thumnailUrl?.isNotEmpty ?? false)
            ImageWidget(widget.thumnailUrl!)
          else if (widget.onlyPlayFullscreen == false)
            Stack(
              children: [
                IgnorePointer(
                  ignoring: false,
                  child: Center(child: player),
                ),
                if (widget.builderVideoControl != null)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: widget.builderVideoControl!(
                      _customVideoPlayerController!.videoPlayerController,
                      () => _onTapFullScreen(player),
                    ),
                  ),
              ],
            )
          else
            Container(color: Colors.transparent),
          if (widget.onlyPlayFullscreen)
            ValueListenableBuilder<bool>(
              valueListenable: iconPlayNotifier,
              builder: (context, value, child) => value
                  ? const SizedBox()
                  : SizedBox(
                      width: w,
                      // height: w * videoRatio,
                      child: AspectRatio(
                        aspectRatio: widget.videoRatio,
                        child: Center(
                          child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () => _onTapFullScreen(player),
                            onLongPress: widget.onLongPress,
                            child: SizedBox(
                              width: double.infinity,
                              height: double.infinity,
                              child: widget.iconPlay ??
                                  const ImageWidget(
                                    VideoIconConstants.play,
                                    color: Colors.white,
                                    package: kPackageMedia,
                                    width: 50,
                                    height: 50,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
          if (widget.isShowLoading &&
              videoPlayerController?.value.isInitialized == false)
            AspectRatio(
              aspectRatio: widget.videoRatio,
              child: const Skeleton(),
            ),
        ],
      ),
    );
    return videoWidget;
  }

  void _onTapFullScreen(Widget player) {
    Navigator.of(context)
        .push(
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
            player: player,
            heroTag: widget.tag ?? widget.videoUrl,
            aspectRatio: _customVideoPlayerController!
                .videoPlayerController.value.aspectRatio,
            buildControllerWidget: widget.builderVideoControl != null
                ? (callbackFullScreen) {
                    return widget.builderVideoControl!(
                      _customVideoPlayerController!.videoPlayerController,
                      callbackFullScreen,
                    );
                  }
                : null,
          ),
        ),
      ),
    )
        .then((value) {
      _customVideoPlayerController?.videoPlayerController.pause();
    });
    _customVideoPlayerController?.videoPlayerController.play();
  }
}
