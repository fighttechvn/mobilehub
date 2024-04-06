import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:imagewidget/imagewidget.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../video/mixins/player_control_mixin.dart';
import '../video/player/single_player_manager.dart';
import '../video_constants.dart';
import '../widgets/easy_debounce.dart';
import '../widgets/loading_widget.dart';

class VideoSocialWidget extends StatefulWidget {
  final String url;
  final bool play;
  final bool isLoop;
  final bool enableSeek;
  final int index;
  final Function()? onTapComment;
  final Function()? onFinish;
  final VideoControllerAction? controllerAction;
  final EdgeInsets? paddingSlider;
  final bool enableBackgroundSlider;

  const VideoSocialWidget({
    Key? key,
    required this.url,
    this.play = true,
    this.index = 0,
    this.onTapComment,
    this.isLoop = true,
    this.onFinish,
    this.controllerAction,
    this.enableSeek = true,
    this.enableBackgroundSlider = false,
    this.paddingSlider,
  }) : super(key: key);
  @override
  State<VideoSocialWidget> createState() => _VideoSocialWidgetState();
}

class _VideoSocialWidgetState extends State<VideoSocialWidget>
    with PlayerControlMixin, SinglePlayerPlayingMixin {
  late GlobalKey globalKeyCenterButton;
  VideoPlayerController? _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool initDone = false;
  bool visibilityDetector = false;

  Duration? _position;
  bool _isFirstPlay = false;

  double _mathScale(Size size, double aspectRatio) {
    final renderBox =
        globalKeyCenterButton.currentContext!.findRenderObject() as RenderBox?;

    var maxH = 0.0;
    var maxW = 0.0;
    var minH = 0.0;
    var minW = 0.0;
    final Size sizeScreen = renderBox?.size ?? size;

    minH = sizeScreen.height;
    minW = minH * aspectRatio;
    maxW = sizeScreen.width;
    maxH = maxW / aspectRatio;

    if (minW > maxW) {
      final tempW = minW;
      minW = maxW;
      maxW = tempW;

      final tempH = minH;
      minH = maxH;
      maxH = tempH;
    }

    return maxH / minH;
  }

  bool _isFinish = false;

  void _listenerOnFinish() {
    if (_controller != null) {
      final position = _controller!.value.position.inSeconds;
      final duration = _controller!.value.duration.inSeconds;

      if (duration != 0 && position == duration && _isFinish == false) {
        _isFinish = true;
        widget.onFinish?.call();
      } else if (position != duration) {
        _isFinish = false;
      }
    }
  }

  @override
  VideoPlayerController? get controller => _controller;

  @override
  void initState() {
    if (enableLogVideoDebug) {
      debugPrint('[VideoSocialWidget] url: ${widget.url}');
    }

    globalKeyCenterButton = GlobalKey(debugLabel: widget.url);
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url));

    _initializeVideoPlayerFuture = _controller!.initialize().then((_) {
      // Ensure the first frame is shown after the video is initialized,
      // even before the play button has been pressed.
      setState(() {
        if (visibilityDetector) {
          _controller?.play();
          setTimer();
        }

        initDone = true;
        if (widget.isLoop) {
          _controller?.setLooping(true);
        }
      });
    });

    if (widget.onFinish != null) {
      _controller?.addListener(_listenerOnFinish);
    }
    if (widget.controllerAction != null) {
      widget.controllerAction!.pauseVideo = pauseVideo;
      widget.controllerAction!.playVideo = playVideo;
    }

    super.initState();
  }

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
    return _controller!;
  }

  @override
  void dispose() {
    if (enableLogVideoDebug) {
      debugPrint('[VideoSocialWidget] dispose url: ${widget.url}');
    }

    initDone = false;

    if (widget.onFinish != null) {
      if (_controller != null) {
        _controller!.removeListener(_listenerOnFinish);
      }
    }

    _controller?.dispose();
    _controller = null;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null) {
      return const SizedBox();
    }
    return GestureDetector(
      onTap: () {
        _isFirstPlay = true;
        onTapPlayer();
      },
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: globalKeyCenterButton,
        backgroundColor: Colors.black,
        body: VisibilityDetector(
          key: ValueKey('${widget.key}VisibilityDetector$hashCode'),
          onVisibilityChanged: (info) {
            if (info.visibleFraction < 0.4 ||
                (info.visibleFraction > 0.7 && info.visibleFraction < 1)) {
              visibilityDetector = false;
              if (initDone) {
                showControl();

                _controller?.pause();
              }
            } else if (info.visibleFraction == 1) {
              visibilityDetector = true;
              if (initDone) {
                _controller?.play();
                setTimer();
              }
            }
          },
          child: Stack(
            children: [
              FutureBuilder(
                future: _initializeVideoPlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (_controller!.value.aspectRatio > 0.6) {
                      return Center(
                        child: AspectRatio(
                          aspectRatio: _controller!.value.aspectRatio,
                          child: VideoPlayer(_controller!),
                        ),
                      );
                    }

                    final scaleVideo = _mathScale(
                      MediaQuery.of(context).size,
                      _controller!.value.aspectRatio,
                    );

                    return Center(
                      child: Transform.scale(
                        scale: scaleVideo,
                        child: AspectRatio(
                          aspectRatio: _controller!.value.aspectRatio,
                          child: VideoPlayer(_controller!),
                        ),
                      ),
                    );
                  } else {
                    return const Center(child: LoadingWidget());
                  }
                },
              ),
              builderListenShowController(
                builder: () {
                  return AnimatedBuilder(
                    animation: _controller!,
                    builder: (_, __) {
                      if (_isFirstPlay == false) {
                        return const SizedBox();
                      }

                      return Container(
                        color: Colors.transparent,
                        child: Center(
                          child: _controller!.value.isPlaying == false
                              ? Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black26,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  padding: const EdgeInsets.all(25),
                                  child: const ImageWidget(
                                    VideoIconConstants.play,
                                    package: kPackageMedia,
                                    height: 40,
                                    width: 40,
                                  ),
                                )
                              : const SizedBox(),
                          // Icon(
                          //   _controller!.value.isPlaying
                          //       ? Icons.pause
                          //       : Icons.play,
                          //   size: 60,
                          //   color: Colors.white.withOpacity(0.3),
                          // ),
                        ),
                      );
                    },
                  );
                },
              ),
              if (widget.enableBackgroundSlider)
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                    height: MediaQuery.sizeOf(context).height / 2,
                    width: MediaQuery.sizeOf(context).width,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black54,
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: widget.paddingSlider ??
                            EdgeInsets.only(
                              bottom: widget.onTapComment != null ? 0 : 40,
                            ),
                        child: IgnorePointer(
                          ignoring: widget.enableSeek == false,
                          child: AnimatedContainer(
                            height: _position != null ? 10 : 4,
                            duration: const Duration(milliseconds: 250),
                            child: SliderTheme(
                              data: SliderThemeData(
                                thumbColor: Colors.white,
                                thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius: _position != null ? 5 : 2,
                                ),
                                trackHeight: 2,
                                activeTrackColor: Colors.white,
                                inactiveTrackColor: Colors.white60,
                                overlayShape: SliderComponentShape.noThumb,
                              ),
                              child: ValueListenableBuilder<VideoPlayerValue>(
                                valueListenable: _controller!,
                                builder: (_, value, __) {
                                  final pos = _position ?? value.position;
                                  return Slider(
                                    onChanged: (mili) => onSlideChange(
                                      Duration(milliseconds: mili.toInt()),
                                    ),
                                    onChangeEnd: (mili) => onSlideChangeEnd(
                                      Duration(milliseconds: mili.toInt()),
                                    ),
                                    value: max(
                                      min(
                                        pos.inMilliseconds.toDouble(),
                                        value.duration.inMilliseconds
                                            .toDouble(),
                                      ),
                                      0,
                                    ),
                                    min: 0.0,
                                    max: value.duration.inMilliseconds
                                        .toDouble(),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (widget.onTapComment != null)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20)
                              .copyWith(
                            bottom: MediaQuery.of(context).padding.bottom > 0
                                ? MediaQuery.of(context).padding.bottom
                                : 10,
                            top: 16,
                          ),
                          width: double.infinity,
                          color: Colors.black,
                          child: GestureDetector(
                            onTap: widget.onTapComment,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: const Color(0xFFD3D3D3),
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 20,
                              ),
                              child: Text(
                                'Viết bình luận',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(color: const Color(0xFFD3D3D3)),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onSlideChange(Duration duration) {
    if (mounted) {
      setState(() {
        _position = duration;
      });
    }
  }

  void onSlideChangeEnd(Duration duration) {
    seek(duration);
    if (mounted) {
      setState(() {
        _position = null;
      });
    }
  }

  void seek(Duration position) {
    controller?.seekTo(position);
  }

  void playVideo() {
    _isFirstPlay = true;
    if (controller != null) {
      EasyDebounce.debounce('deboundplayVideo${controller!.hashCode}',
          const Duration(milliseconds: 200), () async {
        if (controller!.value.isPlaying == false) {
          await controller!.play();
          setTimer();
        }
      });
    }
  }

  void pauseVideo() {
    _isFirstPlay = true;
    if (controller != null) {
      EasyDebounce.debounce('deboundpauseVideo${controller!.hashCode}',
          const Duration(milliseconds: 200), () async {
        if (controller!.value.isPlaying) {
          await controller!.pause();
          showControl();
        }
      });
    }
  }
}

class VideoControllerAction {
  void Function()? playVideo;
  void Function()? pauseVideo;
}
