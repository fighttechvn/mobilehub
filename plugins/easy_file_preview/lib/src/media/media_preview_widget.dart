import 'package:easy_video/easy_video.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../pdf/widgets/pdf_widget.dart';
import '../webview_preview_pdf/view_file_widget.dart';
import '../widgets/launcher_helper.dart';

class MediaPreviewWidget extends StatelessWidget {
  final String? type;
  final String url;
  final String? title;
  final bool pdfFullScreen;
  final double? minHeightPdf;
  final Widget? Function(String url)? builder;

  const MediaPreviewWidget({
    super.key,
    this.type,
    required this.url,
    this.title,
    this.minHeightPdf,
    this.pdfFullScreen = false,
    this.builder,
  });

  @override
  Widget build(BuildContext context) {
    final widget = builder?.call(url);
    if (widget != null) {
      return widget;
    }

    final fileType = type ?? url.split('.').last;
    for (final e in [
      '.png',
      '.jpg',
      '.JPEG',
      '.svg',
    ]) {
      if (url.toLowerCase().contains(e.toLowerCase())) {
        return ImageWidget(url);
      }
    }

    if ('.pdf'.contains(fileType.toLowerCase())) {
      return SizedBox(
        height: minHeightPdf,
        child: PDFViewWidget(
          filePath: url,
          title: title,
          showButtonFullScreen: pdfFullScreen,
        ),
      );
    } else if ([
      'mov',
      '.mov',
      'mp4',
      '.mp4',
    ].contains(fileType.toLowerCase())) {
      return VideoPostWidget(
        video: ImageInfoData(
          url,
          null,
          null,
          'video',
        ),
        onlyPlayFullscreen: false,
        playCenter: false,
        controlBarAvailable: false,
        autoPlay: false,
        aspecRatio: 2,
      );
    } else if ([
      'ppt',
      '.ppt',
      'doc',
      '.doc',
      '.docx',
      '.ppt',
      'pptx',
      '.pptx',
      'xls',
      '.xls',
      'xlsx',
      '.xlsx',
      'txt',
      '.txt',
      'rtf',
      '.rtf',
    ].contains(fileType.toLowerCase())) {
      return SizedBox(
        height: minHeightPdf,
        child: ViewFileWidget(
          url: url,
          showButtonFullScreen: pdfFullScreen,
          title: title,
        ),
      );
    }

    return Center(
      child: GestureDetector(
        onTap: () => openLink(url),
        onLongPress: () {
          Clipboard.setData(ClipboardData(text: url));
        },
        child: Text(
          title ?? url.split('/').last,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
