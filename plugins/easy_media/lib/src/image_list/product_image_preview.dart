import 'dart:math';

import 'package:easy_media/easy_media.dart';
import 'package:flutter/material.dart';
import 'package:imagewidget/imagewidget.dart';
import 'package:mobilehub_core/mobilehub_core.dart';

class ProductImagePreview extends StatefulWidget {
  const ProductImagePreview({
    super.key,
    required this.images,
  });

  final List<String> images;

  @override
  State<ProductImagePreview> createState() => _ProductImagePreviewState();
}

class _ProductImagePreviewState extends State<ProductImagePreview> {
  final selectedIdxValue = ValueNotifier(0);

  List<String> get images => widget.images;

  final scrollCrl = ScrollController();
  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return const SizedBox();
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        final imageSize = (constraints.maxWidth - 12 * 4) / 5;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: PageView.builder(
                controller: pageController,
                itemCount: images.length,
                onPageChanged: (value) {
                  EasyDebounce.debounce(
                      '${runtimeType}_${hashCode}_onPageChange',
                      const Duration(milliseconds: 200), () {
                    scrollCrl.animateTo(
                      value * (imageSize + 24),
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.linear,
                    );
                    selectedIdxValue.value = value;
                  });
                },
                itemBuilder: (context, index) {
                  final image = images[index];
                  final tag = '${image}_$index';
                  return InkWell(
                    onTap: () {
                      context.openImageGallery(
                        images: images,
                        forcusIndex: index,
                        heroTag: tag,
                        rootNavigator: true,
                      );
                    },
                    child: Hero(
                      tag: tag,
                      child: ExtendedImage.network(
                        image,
                        cache: true,
                        fit: BoxFit.cover,
                        width: imageSize,
                        height: imageSize,
                        // loadStateChanged: loadStateChanged,
                      ),
                    ),
                  );
                },
              ),
            ),
            if (images.length > 1) ...[
              const SizedBox(height: 12),
              SizedBox(
                height: imageSize,
                child: Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: [
                    ValueListenableBuilder<int>(
                      valueListenable: selectedIdxValue,
                      builder: (context, selectedIdx, snapshot) {
                        return ListView.separated(
                          physics: const ClampingScrollPhysics(),
                          controller: scrollCrl,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () => pageController.animateToPage(
                                index,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.linear,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: index == selectedIdx
                                      ? const Color(0xff5C5C5C)
                                      : null,
                                ),
                                child: ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                    index == selectedIdx
                                        ? const Color(0xff929292)
                                        : Colors.white,
                                    BlendMode.modulate,
                                  ),
                                  child: ExtendedImage.network(
                                    key: ValueKey('${images[index]}_$index'),
                                    images[index],
                                    cache: true,
                                    fit: BoxFit.cover,
                                    width: imageSize,
                                    height: imageSize,
                                    border: Border.all(color: Colors.blue),
                                    colorBlendMode: BlendMode.hue,
                                    // loadStateChanged: loadStateChanged,
                                  ),
                                ),
                              ),
                            );
                          },
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (_, __) =>
                              const SizedBox(width: 24),
                          itemCount: images.length,
                        );
                      },
                    ),
                    InkWell(
                      onTap: () {
                        pageController.animateToPage(
                          min(selectedIdxValue.value + 1, images.length - 1),
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.linear,
                        );
                      },
                      child: Container(
                        width: 24,
                        color: Colors.black12,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.chevron_right,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ],
        );
      },
    );
  }
}
