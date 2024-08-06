import 'dart:io';

import 'package:easy_loading_adaptive/easy_loading.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import '../../media_files_coodinator.dart';
import '../core/pdf_helper.dart';

class PDFViewWidget extends StatefulWidget {
  const PDFViewWidget({
    super.key,
    required this.filePath,
    this.showButtonControl = false,
    this.showButtonFullScreen = false,
    this.title,
    this.controller,
  });

  final String filePath;
  final bool showButtonControl;
  final bool showButtonFullScreen;
  final String? title;
  final PDFViewController? controller;

  @override
  State<PDFViewWidget> createState() => _PDFViewWidgetState();
}

class _PDFViewWidgetState extends State<PDFViewWidget> {
  int currentPage = 0;
  int totalPage = 0;

  PDFViewController? controller;

  var _downloadingPdfComplete = false;
  var _localPath = '';
  File? _localFile;

  var _hasError = false;

  @override
  void initState() {
    if (widget.filePath.contains('http')) {
      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) {
          createFileOfPdfUrl(widget.filePath).then((value) {
            _localPath = value.path;
            _localFile = value;

            setState(() {
              _downloadingPdfComplete = true;
            });
          }).catchError((e) {
            setState(() {
              _downloadingPdfComplete = true;
              _hasError = true;
            });
          });
        },
      );
    } else {
      _localPath = widget.filePath;
      _downloadingPdfComplete = true;
    }
    super.initState();
  }

  @override
  void dispose() {
    _localFile?.delete();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewPdfWidget = PDFView(
      enableSwipe: true,
      filePath: _localPath,
      nightMode: Theme.of(context).brightness == Brightness.dark,
      gestureRecognizers: {
        Factory(() {
          return VerticalDragGestureRecognizer();
        }),
      },
      onRender: (pages) {
        if (pages != null) {
          setState(() {
            totalPage = pages;
          });
        }
      },
      onError: (error) {
        if (kDebugMode) {
          print('[PdfWidget] error: $error');
        }
      },
      onPageError: (page, error) {
        if (kDebugMode) {
          print('[PdfWidget] $page: ${error.toString()}');
        }
      },
      onViewCreated: (PDFViewController pdfViewController) {
        controller = pdfViewController;
      },
      onPageChanged: (page, total) {
        if (page != null) {
          setState(() {
            currentPage = page;
          });
        }
      },
    );

    if (_hasError) {
      return const Text('Can not preview file.');
    }

    return Stack(
      children: [
        _downloadingPdfComplete == false
            ? const LoadingWidget()
            : viewPdfWidget,
        if (widget.showButtonFullScreen)
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomRight,
              child: SafeArea(
                child: SizedBox(
                  child: IconButton(
                    onPressed: () {
                      context.startViewPdf(
                        filePath: _localPath,
                        hero: viewPdfWidget,
                        title: widget.title,
                        controller: controller,
                      );
                    },
                    icon: const Icon(Icons.fullscreen),
                  ),
                ),
              ),
            ),
          ),
        if (widget.showButtonControl)
          Positioned.fill(
            child: Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    (currentPage > 0)
                        ? Container(
                            decoration: const BoxDecoration(color: Colors.grey),
                            child: IconButton(
                              icon: const Icon(Icons.arrow_upward),
                              color: Colors.black,
                              onPressed: () {
                                if (currentPage > 0) {
                                  controller?.setPage(currentPage - 1);
                                }
                              },
                            ),
                          )
                        : Container(
                            decoration:
                                const BoxDecoration(color: Colors.transparent),
                            child: const Icon(
                              Icons.arrow_upward,
                              color: Colors.transparent,
                            ),
                          ),
                    (currentPage == (totalPage - 1))
                        ? Container(
                            decoration:
                                const BoxDecoration(color: Colors.transparent),
                            child: const Icon(
                              Icons.arrow_downward,
                              color: Colors.transparent,
                            ),
                          )
                        : Container(
                            decoration: const BoxDecoration(color: Colors.grey),
                            child: IconButton(
                              icon: const Icon(Icons.arrow_downward),
                              color: Colors.black,
                              onPressed: () {
                                if (currentPage < totalPage) {
                                  controller?.setPage(currentPage + 1);
                                }
                              },
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
