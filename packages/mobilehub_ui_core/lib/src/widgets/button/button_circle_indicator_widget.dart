import 'package:flutter/material.dart';

import '../../animations/circle_progress_indicator/animated_circle_progress_indicator.dart';
import 'elevated_button_shadow.dart';

class ButtonCircleIndicatorWidget extends StatefulWidget {
  final void Function()? onTap;
  final double value;
  final String title;
  final TextStyle styleTitle;
  final double size;
  final double spacer;
  final double padding;
  final ValueNotifier<double>? controller;

  const ButtonCircleIndicatorWidget({
    super.key,
    this.onTap,
    this.value = 0,
    required this.title,
    this.styleTitle = const TextStyle(color: Colors.white),
    this.size = 90,
    this.spacer = 10,
    this.padding = 9,
    this.controller,
  });

  @override
  State<ButtonCircleIndicatorWidget> createState() =>
      _ButtonCircleIndicatorWidgetState();
}

class _ButtonCircleIndicatorWidgetState
    extends State<ButtonCircleIndicatorWidget> {
  late ValueNotifier<double> _valueCtr;

  void _onTapButton() {
    widget.onTap?.call();
    final newValue = _valueCtr.value + 0.2;

    if (newValue > 1) {
      _valueCtr.value = 0;
    } else {
      _valueCtr.value = newValue;
    }
  }

  @override
  void initState() {
    _valueCtr = widget.controller ?? ValueNotifier<double>(widget.value);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ButtonCircleIndicatorWidget oldWidget) {
    if (widget.value != oldWidget.value) {
      _valueCtr.value = widget.value;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _valueCtr,
      builder: (context, child) {
        return AnimatedCircleProgressIndicator(
          value: _valueCtr.value,
          strokeWidth: 2,
          size: widget.size,
          child: ElevatedButtonShadow(
            height: widget.size - widget.spacer,
            width: widget.size - widget.spacer,
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.all(widget.padding),
            borderRadius: widget.size / 2,
            onPressed: _onTapButton,
            child: Center(
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  widget.title,
                  style: widget.styleTitle,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
