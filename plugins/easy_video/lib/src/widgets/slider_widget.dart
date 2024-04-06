import 'dart:math';

import 'package:flutter/material.dart';

class SliderWidget extends StatelessWidget {
  const SliderWidget({
    super.key,
    required this.onSlideChangeEnd,
    required this.onSlideChange,
    this.position,
    required this.duration,
  });

  final void Function(Duration duration) onSlideChangeEnd;
  final void Function(Duration duration) onSlideChange;
  final Duration? position;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    final pos = position ?? Duration.zero;
    return AnimatedContainer(
      height: position != null ? 10 : 4,
      duration: const Duration(milliseconds: 250),
      child: SliderTheme(
        data: SliderThemeData(
          thumbColor: Colors.white,
          thumbShape: RoundSliderThumbShape(
            enabledThumbRadius: position != null ? 5 : 2,
          ),
          trackHeight: 2,
          activeTrackColor: Colors.white,
          inactiveTrackColor: Colors.white60,
          overlayShape: SliderComponentShape.noThumb,
        ),
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
              duration.inMilliseconds.toDouble(),
            ),
            0,
          ),
          min: 0.0,
          max: duration.inMilliseconds.toDouble(),
        ),
      ),
    );
  }
}
