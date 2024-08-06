import 'package:flutter/material.dart';

import '../widgets/launcher_helper.dart';
import 'media_preview_widget.dart';

extension Extmedia on String? {
  bool get isFilePreviewSupported =>
      this == '.pdf' ||
      [
        '.mov',
        '.mp4',
        '.xls',
        '.xlsx',
        '.doc',
        '.docx',
        '.txt',
      ].contains(this?.toLowerCase());

  bool get isMediaSupportedLink =>

      /// doc
      this?.toLowerCase().contains('.doc') == true ||
      this?.toLowerCase().contains('.docx') == true ||
      this?.toLowerCase().contains('.xlsx') == true ||
      this?.toLowerCase().contains('.xls') == true ||

      // pdf
      this?.toLowerCase().contains('.pdf') == true ||

      /// image
      this?.toLowerCase().contains('.png') == true ||
      this?.toLowerCase().contains('.jpg') == true ||

      /// video
      this?.toLowerCase().contains('.mp4') == true ||
      this?.toLowerCase().contains('.mov') == true;
}

Future<void> _launchURL(String url) async {
  return openLink(url);
}

class MediaDownloadWidget extends StatelessWidget {
  const MediaDownloadWidget({
    super.key,
    required this.type,
    required this.url,
    this.title,
  });
  final String type;
  final String url;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: MediaPreviewWidget(
            type: type,
            url: url,
            title: title!,
            pdfFullScreen: false,
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomRight,
            child: SafeArea(
              minimum: const EdgeInsets.all(12),
              child: SizedBox(
                child: IconButton(
                  onPressed: () {
                    _launchURL(url);
                  },
                  icon: const Icon(Icons.download),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
