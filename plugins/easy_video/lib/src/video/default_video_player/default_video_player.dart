import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class DefaultVideoPlayer extends StatefulWidget {
  final String package;
  final String source;
  final bool isPlay;
  final bool isLoop;

  const DefaultVideoPlayer({
    super.key,
    required this.source,
    this.isPlay = true,
    this.isLoop = true,
    this.package = 'design_system',
  });

  @override
  State<DefaultVideoPlayer> createState() => _DefaultVideoPlayerState();
}

class _DefaultVideoPlayerState extends State<DefaultVideoPlayer> {
  late VideoPlayerController _controller;

  bool _ctrInitialed = false;

  @override
  void initState() {
    _controller = Uri.parse(widget.source).isAbsolute
        ? VideoPlayerController.networkUrl(Uri.parse(widget.source))
        : VideoPlayerController.asset(
            widget.source,
            package: widget.package,
          );
    _controller.initialize().then((value) {
      _ctrInitialed = true;
      _controller.setLooping(widget.isLoop);
      if (widget.isPlay) {
        _playOrPause();
      }
    });

    super.initState();
  }

  @override
  void didUpdateWidget(covariant DefaultVideoPlayer oldWidget) {
    if (oldWidget.isPlay != widget.isPlay) {
      _playOrPause();
    }

    _controller.setLooping(widget.isLoop);
    super.didUpdateWidget(oldWidget);
  }

  void _playOrPause() {
    if (!_ctrInitialed) {
      return;
    }
    if (widget.isPlay) {
      _controller.play();
    } else {
      _controller.pause();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VideoPlayer(_controller);
  }
}
