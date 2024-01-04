import 'package:flutter/material.dart';

class ExpansionWidget extends StatefulWidget {
  final Widget child;
  final Widget title;
  final bool isExpend;
  final Duration duration;

  const ExpansionWidget({
    super.key,
    required this.child,
    required this.title,
    this.isExpend = false,
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  State<ExpansionWidget> createState() => _ExpansionWidgetState();
}

class _ExpansionWidgetState extends State<ExpansionWidget>
    with SingleTickerProviderStateMixin {
  final _keyWidget = GlobalKey();
  late AnimationController _controller;
  late Animation<double> _animation;
  double? _heightSetItem;

  void _setHeight() {
    if (_heightSetItem == null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        final Size? sizeWidget = _keyWidget.currentContext?.size;

        if (sizeWidget != null) {
          _heightSetItem = sizeWidget.height;
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _animation = Tween<double>(
      begin: widget.isExpend ? 1.0 : 0.0,
      end: widget.isExpend ? 0.0 : 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
        reverseCurve: Curves.easeOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _setHeight();

    return Column(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            if ([AnimationStatus.dismissed].contains(_controller.status)) {
              _controller.forward();
            } else {
              _controller.reverse();
            }
          },
          child: widget.title,
        ),
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return SizedBox(
              height: _heightSetItem == null
                  ? (widget.isExpend ? null : 0)
                  : _heightSetItem! * _animation.value,
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: child,
              ),
            );
          },
          child: SizedBox(
            key: _keyWidget,
            child: widget.child,
          ),
        ),
      ],
    );
  }
}
