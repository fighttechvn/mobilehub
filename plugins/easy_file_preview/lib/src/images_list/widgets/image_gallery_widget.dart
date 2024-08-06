import 'package:flutter/material.dart';
import 'package:imagewidget/imagewidget.dart';

import 'page_indicator_widget.dart';

class ImageGalleryWidget extends StatefulWidget {
  const ImageGalleryWidget({
    super.key,
    required this.images,
    this.forcusIndex = 0,
    this.heroTag,
  });

  final List<String> images;
  final int forcusIndex;
  final String? heroTag;

  @override
  State<ImageGalleryWidget> createState() => _ImageGalleryWidgetState();
}

class _ImageGalleryWidgetState extends State<ImageGalleryWidget> {
  late final PageController _pageController;

  final slidePagekey = GlobalKey<ExtendedImageSlidePageState>();

  @override
  void initState() {
    _pageController = PageController(
      initialPage: widget.forcusIndex,
    );
    super.initState();
  }

  List<String> get images => widget.images;

  @override
  Widget build(BuildContext context) {
    final pageCount = images.length;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: ExtendedImageSlidePage(
        key: slidePagekey,
        slideAxis: SlideAxis.both,
        slideType: SlideType.onlyImage,
        slidePageBackgroundHandler: (offset, pageSize) {
          return defaultSlidePageBackgroundHandler(
            offset: offset,
            pageSize: pageSize,
            color: Colors.black,
            pageGestureAxis: SlideAxis.both,
          );
        },
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    itemCount: pageCount,
                    controller: _pageController,
                    itemBuilder: (context, index) {
                      final image = ImageZoom(
                        url: images[index],
                      );
                      if (widget.heroTag.isNotNullOrEmpty) {
                        return HeroWidget(
                          tag: widget.heroTag!,
                          slideType: SlideType.wholePage,
                          slidePagekey: slidePagekey,
                          child: image,
                        );
                      }
                      return image;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom + 16,
                  ),
                  height: 20,
                  child: PageIndicatorWidget(
                    countItem: pageCount,
                    controller: _pageController,
                    color: const Color(0xffA6AFCE),
                    size: const Size(8, 8),
                    activeSize: const Size(8, 8),
                    colorActive: Colors.white,
                    initialPage: widget.forcusIndex,
                  ),
                ),
              ],
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top,
              right: 0,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension NullableStringIsNotNullOrEmptyExtension on String? {
  bool get isNotNullOrEmpty => !isNullOrEmpty;
}

extension NullableStringIsNullOrEmptyExtension on String? {
  /// Returns `true` if the String is either null or empty.
  bool get isNullOrEmpty => this?.isEmpty ?? true;
}
