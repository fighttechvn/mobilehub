import 'package:flutter/material.dart';

import '../../animations/circle_progress_indicator/animated_circle_progress_indicator.dart';
import 'elevated_button_shadow.dart';

class ButtonCircleIndicatorWidget extends StatelessWidget {
  final void Function()? onTap;
  final double value;
  final String title;
  final TextStyle styleTitle;
  final double size;
  final double spacer;
  final double padding;

  const ButtonCircleIndicatorWidget({
    super.key,
    this.onTap,
    required this.value,
    required this.title,
    this.styleTitle = const TextStyle(color: Colors.white),
    this.size = 90,
    this.spacer = 10,
    this.padding = 9,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedCircleProgressIndicator(
        value: value,
        strokeWidth: 2,
        size: size,
        child: ElevatedButtonShadow(
          height: size - spacer,
          width: size - spacer,
          color: Theme.of(context).primaryColor,
          padding: EdgeInsets.all(padding),
          borderRadius: size / 2,
          onPressed: onTap,
          child: Center(
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                title,
                style: styleTitle,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
