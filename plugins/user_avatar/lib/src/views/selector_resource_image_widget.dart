import 'package:flutter/material.dart';

class SelectResourceImageWidget extends StatelessWidget {
  const SelectResourceImageWidget({
    super.key,
    this.onUseCamera,
    this.onUseGallery,
    this.iconCamera,
    this.iconGallery,
    this.title,
    this.titleCamera,
    this.titleGallery,
  });

  final void Function()? onUseCamera;
  final void Function()? onUseGallery;
  final Widget? iconCamera;
  final Widget? iconGallery;
  final String? title;
  final String? titleCamera;
  final String? titleGallery;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 50,
              height: 4,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                title ?? 'Ảnh đại diện',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    onTap: onUseCamera,
                    leading: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child:
                          iconCamera ?? const Icon(Icons.camera_alt_outlined),
                    ),
                    title: Text(titleCamera ?? 'Chụp ảnh mới'),
                    minLeadingWidth: 0,
                  ),
                  ListTile(
                    onTap: onUseGallery,
                    leading: iconGallery ?? const Icon(Icons.image),
                    title: Text(titleGallery ?? 'Chọn ảnh từ thiết bị'),
                    minLeadingWidth: 0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
