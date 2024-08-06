import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageIndicatorWidget extends StatefulWidget {
  final int countItem;
  final PageController? controller;
  final Duration durationTranfer;
  final Duration durationReverce;
  final bool isShowButtonAction;
  final Curve? curve;
  final Curve? curveReverce;
  final Size activeSize;
  final Size size;

  final Color? color;
  final Color? colorActive;
  final Color colorBorder;
  final EdgeInsets spacing;

  /// Use for add animation when change page
  final ValueChanged<double>? onChangePage;
  final bool enableOnTap;
  final int initialPage;

  const PageIndicatorWidget({
    Key? key,
    required this.countItem,
    this.controller,
    this.isShowButtonAction = true,
    this.onChangePage,
    this.durationTranfer = const Duration(milliseconds: 500),
    this.durationReverce = const Duration(milliseconds: 900),
    this.curve,
    this.curveReverce,
    this.color,
    this.colorActive,
    this.colorBorder = Colors.white,
    this.activeSize = const Size(8, 8),
    this.size = const Size(8, 8),
    this.spacing = const EdgeInsets.all(6),
    this.enableOnTap = true,
    this.initialPage = 0,
  }) : super(key: key);

  @override
  State<PageIndicatorWidget> createState() => _PageIndicatorWidgetState();
}

class _PageIndicatorWidgetState extends State<PageIndicatorWidget> {
  double _pageCurrent = 0;

  void _actionGotoPage(double page) {
    if (widget.controller != null) {
      if (widget.onChangePage != null) {
        widget.onChangePage!(page);
      } else {
        final pageNext = page.toInt();

        if (pageNext == 0) {
          widget.controller!.animateToPage(pageNext,
              duration: widget.durationReverce,
              curve: widget.curveReverce ?? Curves.easeInOutBack);
        } else {
          widget.controller!.animateToPage(pageNext,
              duration: widget.durationTranfer,
              curve: widget.curve ?? Curves.ease);
        }
        widget.onChangePage?.call(page);
      }
    } else {
      widget.onChangePage?.call(page);
      setState(() {
        _pageCurrent = page;
      });
    }
  }

  @override
  void initState() {
    _pageCurrent = widget.initialPage.toDouble();
    widget.controller?.addListener(() {
      setState(() {
        _pageCurrent = widget.controller!.page!;
      });
    });

    super.initState();
  }

  @override
  void didUpdateWidget(covariant PageIndicatorWidget oldWidget) {
    if (widget.initialPage != oldWidget.initialPage) {
      setState(() {
        _pageCurrent = widget.initialPage.toDouble();
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final colorDot = widget.color ?? Colors.transparent;
    final colorDotActive = widget.colorActive ?? Colors.white;
    if (widget.countItem <= 1) {
      return const SizedBox();
    }

    return DotsIndicator(
      dotsCount: widget.countItem,
      position: _pageCurrent,
      onTap: widget.enableOnTap == false ? null : _actionGotoPage,
      decorator: DotsDecorator(
        color: colorDot,
        activeColor: colorDotActive,
        activeSize: widget.activeSize,
        activeShape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(widget.activeSize.width / 2)),
        ),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(widget.activeSize.width / 2)),
        ),
        size: widget.size,
        spacing: widget.spacing,
      ),
    );
  }
}

class SmoothPageDotIndicator extends SmoothPageIndicator {
  SmoothPageDotIndicator({
    Key? key,
    required PageController controller,
    required int maxCount,
    Color colorActiveDotBorder = Colors.white,
    Color colorFillDot = Colors.transparent,
    double sizeDot = 8,
    double sizeActiveDot = 8,
    double spacing = 8,
    double withActiveDotBorder = 1,
    double radius = 5,
  }) : super(
          key: key,
          controller: controller,
          count: maxCount,
          effect: CustomizableEffect(
            activeDotDecoration: DotDecoration(
              borderRadius: BorderRadius.circular(radius),
              dotBorder: DotBorder(
                  width: withActiveDotBorder, color: colorActiveDotBorder),
              width: sizeActiveDot,
              height: sizeActiveDot,
            ),
            spacing: spacing,
            dotDecoration: DotDecoration(
              dotBorder: DotBorder(color: colorActiveDotBorder),
              borderRadius: BorderRadius.circular(radius),
              color: colorFillDot,
              width: sizeDot,
              height: sizeDot,
            ),
          ),
        );
}
