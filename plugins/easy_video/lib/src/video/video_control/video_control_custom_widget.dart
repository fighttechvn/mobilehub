import 'dart:math';

import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:imagewidget/imagewidget.dart';

import '../../extensions/duration_ext.dart';
import '../../video_constants.dart';
import '../mixins/player_control_mixin.dart';
import '../player/video_state_manager.dart';

class VideoControlCustomWidget extends StatefulWidget {
  const VideoControlCustomWidget({
    super.key,
    required this.videoPlayerController,
    this.onFullscreen,
    this.showPlayButton = true,
    this.showMuteButton = true,
    this.playCenter = false,
    this.showProgressSlide = true,
    this.showFastSeek = true,
    this.controllerWidget,
    this.onTapCustom,
    this.playColor,
  });

  final VideoPlayerController videoPlayerController;
  final void Function()? onFullscreen;
  final bool showPlayButton;
  final bool showMuteButton;
  final bool playCenter;
  final bool showProgressSlide;
  final bool showFastSeek;
  final ControllerWidgetItem? controllerWidget;
  final void Function()? onTapCustom;
  final Color? playColor;

  @override
  State<VideoControlCustomWidget> createState() =>
      _VideoControlCustomWidgetState();
}

class _VideoControlCustomWidgetState extends State<VideoControlCustomWidget>
    with PlayerControlMixin, VideoPlayerStateManagerMixin {
  @override
  VideoPlayerController get controller => widget.videoPlayerController;
  @override
  Function()? get onTapCustom => widget.onTapCustom;

  late final _controllerWidget = ControllerWidgetItem(
    volumn: widget.controllerWidget?.volumn ??
        _renderIcon(VideoIconConstants.icVolume),
    volumnMute: widget.controllerWidget?.volumnMute ??
        _renderIcon(VideoIconConstants.mute),
  );
  void seek(Duration position) {
    controller.seekTo(position);
  }

  @override
  Widget build(BuildContext context) {
    final buttonPlay = ValueListenableBuilder<VideoPlayerValue>(
      valueListenable: widget.videoPlayerController,
      builder: (_, videoPlayerValue, __) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: onTapPlayer,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              decoration: widget.playColor == null
                  ? null
                  : BoxDecoration(
                      borderRadius: const BorderRadiusDirectional.all(
                        Radius.circular(50),
                      ),
                      color: widget.playColor ?? Colors.transparent,
                    ),
              padding: EdgeInsets.all(widget.playColor != null ? 6 : 0),
              child: Icon(
                videoPlayerValue.isPlaying
                    ? Icons.pause_rounded
                    : Icons.play_arrow_rounded,
                size: widget.playCenter ? 40 : 20,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );

    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return GestureDetector(
      onTap: onTapPlayer,
      behavior: HitTestBehavior.translucent,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 40,
              width: double.infinity,
              padding: EdgeInsets.only(
                bottom: isPortrait ? 0 : 16,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withValues(alpha: 0.0),
                    Colors.black.withValues(alpha: 0.4),
                    Colors.black.withValues(alpha: 0.7),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: ValueListenableBuilder<VideoPlayerValue>(
                valueListenable: widget.videoPlayerController,
                builder: (_, videoPlayerValue, __) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(width: 10),
                      if (widget.playCenter == false) ...[
                        if (widget.showFastSeek) _buildFastPrevSeek(),
                        if (widget.showPlayButton && widget.playCenter == false)
                          buttonPlay,
                        if (widget.showFastSeek) _buildFastNextSeek(),
                      ],
                      Expanded(
                        child: Builder(
                          builder: (context) {
                            if (widget.showProgressSlide) {
                              return _buildSlider();
                            }
                            return const SizedBox();
                          },
                        ),
                      ),
                      if (widget.onFullscreen != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: GestureDetector(
                            onTap: widget.onFullscreen,
                            child: Icon(
                              isPortrait
                                  ? Icons.fullscreen
                                  : Icons.fullscreen_exit,
                              size: 22,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      if (widget.showMuteButton)
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            final isMute = videoPlayerValue.volume == 0;
                            setMute(!isMute);
                            widget.videoPlayerController.setVolume(
                              isMute ? 1 : 0,
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 5,
                            ),
                            child: videoPlayerValue.volume == 0
                                ? _controllerWidget.volumnMute
                                : _controllerWidget.volumn,
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ),
          if (widget.showPlayButton && widget.playCenter)
            builderListenShowController(
              builder: () {
                return Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(48.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (widget.showFastSeek) _buildFastPrevSeek(),
                        if (widget.showPlayButton && widget.playCenter == false)
                          buttonPlay,
                        if (widget.showFastSeek) _buildFastNextSeek(),
                      ],
                    ),
                  ),
                );
              },
            ),
          if (widget.showPlayButton && widget.playCenter)
            builderListenShowController(
              builder: () {
                return Center(child: buttonPlay);
              },
            ),
        ],
      ),
    );
  }

  Widget _renderIcon(String icon, {double size = 20}) => Padding(
        padding: const EdgeInsets.all(5.0),
        child: ImageWidget(
          icon,
          width: size,
          height: size,
          package: kPackageMedia,
        ),
      );

  Duration? _position;
  Widget _buildSlider() {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: SliderTheme(
        data: SliderThemeData(
          thumbColor: Colors.white,
          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 4),
          trackHeight: 1,
          activeTrackColor: Colors.white,
          inactiveTrackColor: Colors.white60,
          overlayShape: SliderComponentShape.noThumb,
        ),
        child: ValueListenableBuilder<VideoPlayerValue>(
          valueListenable: widget.videoPlayerController,
          builder: (_, value, __) {
            final pos = _position ?? value.position;
            return Row(
              children: [
                Container(
                  width: 50,
                  alignment: Alignment.center,
                  child: Text(
                    pos.mmss,
                    style: textTheme.labelSmall?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: Slider(
                    onChanged: (mili) => onSlideChange(
                      Duration(milliseconds: mili.toInt()),
                    ),
                    onChangeEnd: (mili) => onSlideChangeEnd(
                      Duration(milliseconds: mili.toInt()),
                    ),
                    value: max(
                      min(
                        pos.inMilliseconds.toDouble(),
                        value.duration.inMilliseconds.toDouble(),
                      ),
                      0,
                    ),
                    min: 0.0,
                    max: value.duration.inMilliseconds.toDouble(),
                  ),
                ),
                Container(
                  width: 50,
                  alignment: Alignment.center,
                  child: Text(
                    value.duration.mmss,
                    style: textTheme.labelSmall?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void onSlideChange(Duration duration) {
    setState(() {
      _position = duration;
    });
  }

  void onSlideChangeEnd(Duration duration) {
    seek(duration);
    setState(() {
      _position = null;
    });
  }

  Widget _buildFastPrevSeek() {
    final size = widget.playCenter ? 25.0 : 14.0;
    return InkWell(
      onTap: () {
        seek(
          Duration(
            seconds: max(0, controller.value.position.inSeconds - 10),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: ImageWidget(
          VideoIconConstants.icReplay10,
          package: kPackageMedia,
          width: size,
          height: size,
          color: widget.playCenter ? widget.playColor : null,
        ),
      ),
    );
  }

  Widget _buildFastNextSeek() {
    final size = widget.playCenter ? 25.0 : 14.0;

    return InkWell(
      onTap: () {
        seek(
          Duration(
            seconds: min(
              controller.value.duration.inSeconds,
              controller.value.position.inSeconds + 10,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: ImageWidget(
          VideoIconConstants.icForward10,
          package: kPackageMedia,
          width: size,
          height: size,
          color: widget.playCenter ? widget.playColor : null,
        ),
      ),
    );
  }
}

class ControllerWidgetItem {
  final Widget? volumn;
  final Widget? volumnMute;

  ControllerWidgetItem({this.volumn, this.volumnMute});
}
