import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import 'widgets/pdf_widget.dart';

class ViewPdfScreen extends StatefulWidget {
  const ViewPdfScreen({
    super.key,
    this.filePath,
    this.title,
    this.hero,
    this.controller,
  });

  final String? title;
  final String? filePath;
  final Widget? hero;
  final PDFViewController? controller;

  @override
  State<ViewPdfScreen> createState() => _ViewPdfScreenState();
}

class _ViewPdfScreenState extends State<ViewPdfScreen> {
  @override
  Widget build(BuildContext context) {
    // assert(
    //   widget.filePath == null || widget.hero == null,
    //   'Must pass data is filePath or hero widget to render',
    // );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0,
            floating: true,
            leading: IconButton(
              iconSize: 30,
              icon: const Icon(
                Icons.close,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            centerTitle: true,
            title: Text(
              widget.title ?? 'View PDF',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          SliverFillRemaining(
            child: widget.hero ??
                PDFViewWidget(
                  filePath: widget.filePath!,
                  // showButtonControl: false,
                ),
          )
        ],
      ),
    );
  }
}
