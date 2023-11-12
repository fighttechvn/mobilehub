import 'package:flutter/material.dart';
import 'package:imagewidget/imagewidget.dart';

import 'images_list_coodinator.dart';

class HorizontalImagesWidget extends StatelessWidget {
  const HorizontalImagesWidget({
    super.key,
    required this.images,
    this.ratio = 1,
    this.border,
  });

  final List<String> images;
  final double ratio;
  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final tag = '$hashCode${images[index]}_$index';
        return GestureDetector(
          onTap: () {
            context.openImageGallery(
              images: images,
              forcusIndex: index,
              heroTag: tag,
              rootNavigator: true,
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: AspectRatio(
              aspectRatio: ratio,
              child: Hero(
                tag: tag,
                child: ExtendedImage.network(
                  images[index],
                  cache: true,
                  fit: BoxFit.cover,
                  border: border,
                ),
              ),
            ),
          ),
        );
      },
      separatorBuilder: (_, __) => const SizedBox(width: 20),
      itemCount: images.length,
    );
  }
}
