import 'package:easy_video/easy_video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import 'images_list/widgets/image_gallery_widget.dart';
import 'media/media_preview_widget.dart';
import 'pdf/view_pdf_screen.dart';
import 'webview_preview_pdf/view_file_widget.dart';
import 'webview_preview_pdf/webview_fullscreen.dart';

extension ViewPdfCoodinator on BuildContext {
  Future<T?> startViewPdf<T>({
    String? filePath,
    String? title,
    Widget? hero,
    PDFViewController? controller,
  }) {
    return Navigator.of(this).push(MaterialPageRoute(
        builder: (context) => ViewPdfScreen(
              filePath: filePath,
              title: title,
              hero: hero,
            )));
  }

  Future<T?> startVideo<T>({
    required String url,
    String? title,
  }) {
    return Navigator.of(this).push(MaterialPageRoute(
        builder: (context) => TemplateScreenWidget(
              title: title ?? 'View Media',
              child: MediaPreviewWidget(
                minHeightPdf: 400,
                type: '.mp4',
                url: url,
                title: 'video MP',
                pdfFullScreen: true,
              ),
            )));
  }

  Future<T?> startViewMediaFiles<T>(
      {required String url, String? fileName}) async {
    if (url.contains('.png') || url.contains('.jpg')) {
      return openImageGallery(images: [url]);
    } else if (url.contains('pdf')) {
      return startViewPdf(
        filePath: url,
        title: fileName,
      );
    } else if (url.contains('.doc') ||
        url.contains('.docx') ||
        url.contains('.ppt') ||
        url.contains('.pptx') ||
        url.contains('.xls')) {
      return viewFile(url: url, title: fileName);
    } else {
      return startVideo(url: url, title: fileName);
    }
  }

  Future<T?> openImageGallery<T>({
    required List<String> images,
    int forcusIndex = 0,
    String? heroTag,
    bool rootNavigator = false,
  }) {
    return Navigator.of(this, rootNavigator: rootNavigator).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.transparent,
        barrierDismissible: true,
        pageBuilder: (c, a1, a2) => Material(
          color: Colors.transparent,
          child: ImageGalleryWidget(
            images: images,
            forcusIndex: forcusIndex,
            heroTag: heroTag,
          ),
        ),
        transitionsBuilder: (c, anim, a2, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 200),
      ),
    );
  }

  Future<T?> viewFile<T>({required String url, String? title}) async {
    return Navigator.of(this).push(MaterialPageRoute(
        builder: (context) => TemplateScreenWidget(
              title: title ?? 'View File',
              child: ViewFileWidget(
                url: url,
              ),
            )));
  }

  Future<T?> startWebView<T>({
    String? title,
    required String url,
  }) {
    return Navigator.of(this).push(MaterialPageRoute(
        builder: (context) => WebviewFullscreen(
              title: title,
              url: url,
            )));
  }
}
