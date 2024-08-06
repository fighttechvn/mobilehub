import 'package:flutter/material.dart';

class AnimatedCircleProgressIndicator extends StatefulWidget {
  final double value;
  final Color? color;
  final Color? backgroundColor;
  final double strokeWidth;
  final double size;
  final Duration duration;
  final Widget child;

  const AnimatedCircleProgressIndicator({
    super.key,
    required this.value,
    this.color,
    this.backgroundColor,
    this.strokeWidth = 4,
    this.size = 40,
    this.duration = const Duration(milliseconds: 250),
    required this.child,
  });

  @override
  State<AnimatedCircleProgressIndicator> createState() =>
      _AnimatedCircleProgressIndicatorState();
}

class _AnimatedCircleProgressIndicatorState
    extends State<AnimatedCircleProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  double _oldValue = 0;
  double _currentValue = 0;

  @override
  void initState() {
    super.initState();
    _oldValue = widget.value;
    _currentValue = widget.value;
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_animation);
    Future.delayed(const Duration(milliseconds: 200), () {
      _controller.forward(from: 0);
    });
  }

  @override
  void didUpdateWidget(AnimatedCircleProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _oldValue = oldWidget.value;
      _currentValue = widget.value;
      _animation = Tween<double>(
        begin: 0,
        end: 1,
      ).animate(_animation);
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Stack(
            children: [
              Center(
                child: SizedBox(
                  width: widget.size,
                  height: widget.size,
                  child: CircularProgressIndicator(
                    value: _oldValue +
                        (_animation.value * (_currentValue - _oldValue)),
                    valueColor: AlwaysStoppedAnimation(widget.color),
                    backgroundColor: widget.backgroundColor,
                    strokeWidth: widget.strokeWidth,
                  ),
                ),
              ),
              SizedBox(
                height: widget.size,
                child: Center(child: widget.child),
              ),
            ],
          );
        },
      ),
    );
  }
}
