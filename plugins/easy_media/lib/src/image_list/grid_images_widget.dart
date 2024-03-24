import 'package:flutter/material.dart';
import 'package:imagewidget/imagewidget.dart';

import 'images_list_coodinator.dart';

class GridImagesWidget extends StatelessWidget {
  const GridImagesWidget({
    super.key,
    required this.images,
    this.crossAxisCount = 3,
    this.childAspectRatio = 1.0,
    this.mainAxisSpacing = 18.0,
    this.crossAxisSpacing = 20.0,
    this.padding = const EdgeInsets.only(right: 12, top: 16),
    this.pushRootNavigator = true,
  });

  final List<String> images;
  final int crossAxisCount;
  final double childAspectRatio;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final EdgeInsetsGeometry padding;
  final bool pushRootNavigator;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: crossAxisCount,
      childAspectRatio: childAspectRatio,
      padding: padding,
      mainAxisSpacing: mainAxisSpacing,
      crossAxisSpacing: crossAxisSpacing,
      children: [
        ...images.asMap().entries.map(
              (e) => Hero(
                tag: '${hashCode}_${e.value}',
                child: InkWell(
                  onTap: () {
                    context.openImageGallery(
                      images: images,
                      forcusIndex: e.key,
                      heroTag: '${hashCode}_${e.value}',
                      rootNavigator: pushRootNavigator,
                    );
                  },
                  child: ImageWidget(
                    e.value,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
      ],
    );
  }
}
