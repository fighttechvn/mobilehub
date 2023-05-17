import 'package:flutter/material.dart';

import 'measure_size.dart';

class HidableBottomScrollListener extends ChangeNotifier {
  double bottom = 0;
  double _last = 0;
  double _height = 0;

  ScrollController? activeScroll;

  HidableBottomScrollListener(List<ScrollController> controllers) {
    for (final controller in controllers) {
      controller.addListener(() {
        // Prevent bouncing physic
        if (controller.offset < 50) {
          return;
        }
        if (activeScroll != null && activeScroll != controller) {
          _last = 0;
          bottom = _height;
        }

        activeScroll = controller;

        final current = controller.offset;
        bottom += _last - current;
        if (bottom <= -_height) {
          bottom = -_height;
        }
        if (bottom >= 0) {
          bottom = 0;
        }
        _last = current;
        if (bottom <= 0 && bottom >= -_height) {
          notifyListeners();
        }
      });
    }
  }

  double get height => _height;

  void setHeight(double height) {
    _height = height;
    bottom = 0;
    notifyListeners();
  }
}

class HidableBottomNav extends StatefulWidget {
  const HidableBottomNav({
    super.key,
    required this.scrollControllers,
    required this.child,
  });
  final List<ScrollController> scrollControllers;
  final Widget child;

  @override
  State<HidableBottomNav> createState() => HidableBottomNavState();
}

class HidableBottomNavState extends State<HidableBottomNav> {
  late final listener = HidableBottomScrollListener(
    widget.scrollControllers,
  );

  void show() {
    listener.setHeight(listener.height);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: listener,
      builder: (context, child) {
        return SizedBox(
          height: listener.height + listener.bottom,
          child: child!,
        );
      },
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: MeasureSize(
          onChange: (size) {
            final bottomBarHeight = listener.height;
            if (bottomBarHeight < size.height) {
              listener.setHeight(size.height);
            }
          },
          child: widget.child,
        ),
      ),
    );
  }
}
