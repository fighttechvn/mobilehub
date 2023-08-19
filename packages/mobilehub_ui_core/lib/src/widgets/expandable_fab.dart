import 'dart:core';

import 'package:flutter/material.dart';
import 'package:mobilehub_core/mobilehub_core.dart';

class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
    super.key,
    required this.actions,
    this.buttonColor = Colors.white,
    required this.closedIcon,
    this.openedIcon,
    this.size,
    this.separator = const SizedBox(height: 18),
    required this.onTapItem,
  });

  final List<Widget> actions;
  final Color buttonColor;
  final Widget closedIcon;
  final Widget? openedIcon;
  final Widget separator;
  final Size? size;
  final void Function(int index) onTapItem;

  @override
  State<StatefulWidget> createState() {
    return ExpandableFabState();
  }
}

class ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  late AnimationController _animationController;
  final Curve _curve = Curves.easeOut;

  final focusNode = FocusNode();

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..addListener(() {
        setState(() {});
      });

    focusNode.addListener(() {
      if (!focusNode.hasFocus && isOpened) {
        // Close when out focus
        animate();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void animate() {
    if (!isOpened) {
      focusNode.requestFocus();
      _animationController.forward();
    } else {
      focusNode.previousFocus();
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget actions() {
    return Wrap(
      children: [
        Container(
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            color: widget.buttonColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ...widget.actions.mapIndex(
                  (e, idx) => InkWell(
                    child: e,
                    onTap: () {
                      animate();
                      widget.onTapItem.call(idx);
                    },
                  ),
                )
              ].insertSeparator((index) => widget.separator),
            ),
          ),
        ),
      ],
    );
  }

  Widget toggle() {
    final animation = Tween<double>(begin: -1.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    return SizedBox(
      width: widget.size?.width,
      height: widget.size?.height,
      child: FloatingActionButton(
        backgroundColor: widget.buttonColor,
        onPressed: animate,
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Opacity(
              opacity: animation.value.abs(),
              child: Transform.scale(
                scale: animation.value.abs(),
                child:
                    animation.value <= 0 ? child : (widget.openedIcon ?? child),
              ),
            );
          },
          child: widget.closedIcon,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final translateAnim = Tween<double>(
      begin: 56,
      end: -14.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          0.0,
          0.75,
          curve: _curve,
        ),
      ),
    );
    return Focus(
      focusNode: focusNode,
      child: FittedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Transform(
              transform: Matrix4.translationValues(
                0.0,
                translateAnim.value,
                0.0,
              ),
              child: FadeAndScaleItem(
                controller: _animationController,
                curve: _curve,
                child: actions(),
              ),
            ),
            toggle(),
          ],
        ),
      ),
    );
  }
}

class FadeAndScaleItem extends StatelessWidget {
  const FadeAndScaleItem({
    super.key,
    required this.child,
    this.controller,
    this.curve,
  });

  final AnimationController? controller;
  final Curve? curve;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (controller == null || curve == null) {
      return child;
    }

    final animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller!,
        curve: curve!,
      ),
    );
    return AnimatedBuilder(
      animation: controller!,
      builder: (context, _) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: child,
          ),
        );
      },
    );
  }
}
