import 'package:flutter/material.dart';

enum SwitchingAnimation {
  swipeLTR, //Left to right
  swipeRTL, //Right to left
  swipeTTB, //Top to bottom
  swipeBTT, //Bottom to top
}

class LayoutSwitching extends StatefulWidget {
  final Duration duration;
  final Widget first;
  final Widget second;
  final bool isFirstLayout;
  final SwitchingAnimation direction;

  const LayoutSwitching({
    Key? key,
    required this.first,
    required this.second,
    this.isFirstLayout = true,
    this.duration = const Duration(milliseconds: 250),
    this.direction = SwitchingAnimation.swipeRTL,
  }) : super(key: key);

  @override
  State<LayoutSwitching> createState() => _LayoutSwitchingState();
}

class _LayoutSwitchingState extends State<LayoutSwitching> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: widget.duration,
      reverseDuration: widget.duration,
      transitionBuilder: (child, animation) {
        return widget.direction.transitionBuilder(
          child,
          animation,
        );
      },
      child: SizedBox(
        key: ValueKey('$hashCode - ${widget.isFirstLayout}'),
        child: widget.isFirstLayout ? widget.first : widget.second,
      ),
    );
  }
}

extension _SwitchDirectionExt on SwitchingAnimation {
  Widget transitionBuilder(
    Widget child,
    Animation<double> animation,
  ) {
    switch (this) {
      case SwitchingAnimation.swipeRTL:
      case SwitchingAnimation.swipeLTR:
        return _buildHorizontalAnim(
          child,
          animation,
        );
      case SwitchingAnimation.swipeBTT:
      case SwitchingAnimation.swipeTTB:
        return _buildVerticalAnim(
          child,
          animation,
        );
      default:
    }
    return child;
  }

  Widget _buildHorizontalAnim(
    Widget child,
    Animation<double> animation,
  ) {
    Offset begin, end;
    if (this == SwitchingAnimation.swipeLTR) {
      if (animation.isDismissed ||
          animation.status == AnimationStatus.reverse) {
        begin = const Offset(-1, 0);
        end = const Offset(0, 0);
      } else {
        begin = const Offset(1, 0);
        end = const Offset(0, 0);
      }
    } else {
      if (animation.isDismissed ||
          animation.status == AnimationStatus.reverse) {
        begin = const Offset(1, 0);
        end = const Offset(0, 0);
      } else {
        begin = const Offset(-1, 0);
        end = const Offset(0, 0);
      }
    }

    return SlideTransition(
      position: Tween<Offset>(
        begin: begin,
        end: end,
      ).animate(animation),
      child: child,
    );
  }

  Widget _buildVerticalAnim(
    Widget child,
    Animation<double> animation,
  ) {
    Offset begin, end;
    if (this == SwitchingAnimation.swipeBTT) {
      if (animation.isDismissed ||
          animation.status == AnimationStatus.reverse) {
        begin = const Offset(0, 1);
        end = const Offset(0, 0);
      } else {
        begin = const Offset(0, -1);
        end = const Offset(0, 0);
      }
    } else {
      if (animation.isDismissed ||
          animation.status == AnimationStatus.reverse) {
        begin = const Offset(0, -1);
        end = const Offset(0, 0);
      } else {
        begin = const Offset(0, 1);
        end = const Offset(0, 0);
      }
    }

    return SlideTransition(
      position: Tween<Offset>(
        begin: begin,
        end: end,
      ).animate(animation),
      child: child,
    );
  }
}
