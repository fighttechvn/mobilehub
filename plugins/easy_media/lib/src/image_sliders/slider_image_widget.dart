import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:imagewidget/imagewidget.dart';
import 'package:mobilehub_core/mobilehub_core.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SliderImageWidget extends StatefulWidget {
  final List<String> images;
  final double ratio;
  final void Function(String, int)? onTap;
  final EdgeInsetsGeometry padding;
  final BorderRadius itemBorderRadius;
  final Color? inactiveIndicatorColor;
  final Color? activeIndicatorColor;
  final double viewportFraction;
  final Size activeSize;
  final Widget Function(String url)? videoBuilder;
  final BoxFit? boxFit;
  final bool autoPlay;

  const SliderImageWidget({
    super.key,
    this.ratio = 2,
    this.onTap,
    this.padding = EdgeInsets.zero,
    this.itemBorderRadius = const BorderRadius.all(Radius.circular(8)),
    this.inactiveIndicatorColor = Colors.white,
    this.activeIndicatorColor = Colors.white,
    this.viewportFraction = 0.95,
    required this.images,
    this.activeSize = const Size(12.0, 4.0),
    this.videoBuilder,
    this.boxFit,
    this.autoPlay = true,
  });

  @override
  State<SliderImageWidget> createState() => _SliderImageWidgetState();
}

class _SliderImageWidgetState extends State<SliderImageWidget> {
  final controller = PageController();
  late List<String> _images;

  @override
  void initState() {
    _images = widget.images.where((element) => element.isNotEmpty).toList();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant SliderImageWidget oldWidget) {
    if (oldWidget.images != widget.images) {
      setState(() {
        _images = widget.images.where((element) => element.isNotEmpty).toList();
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (_images.isEmpty) {
      return kDebugMode
          ? Container(
              color: Colors.amber,
              height: 100,
              child: const Text('empty list'),
            )
          : const SizedBox();
    }

    return AspectRatio(
      aspectRatio: widget.ratio,
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return PageView(
                controller: controller,
                allowImplicitScrolling: true,
                children: List.generate(_images.length, (index) {
                  final e = _images[index];
                  return Padding(
                    padding: widget.padding,
                    child: InkWell(
                      onTap: () {
                        if (widget.onTap != null) {
                          widget.onTap!(e, index);
                        } else {
                          if (e.isNotNullOrEmpty) {}
                        }
                      },
                      child: e.contains('mp4') || e.contains('.mov')
                          ? widget.videoBuilder?.call(e)
                          : ImageWidget(
                              e,
                              fit: widget.boxFit ?? BoxFit.fitWidth,
                              width: double.infinity,
                            ),
                    ),
                  );
                }),
              );
            },
          ),
          if (_images.length > 1)
            Padding(
              padding: const EdgeInsets.all(4.0).copyWith(bottom: 8),
              child: SmoothPageIndicator(
                controller: controller,
                effect: const ScrollingDotsEffect(
                  activeDotColor: Colors.white,
                  activeDotScale: 1,
                  dotHeight: 8,
                  dotWidth: 8,
                  spacing: 5,
                ),
                count: _images.length,
              ),
            ),
        ],
      ),
    );
  }
}
