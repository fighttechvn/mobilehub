import 'package:flutter/material.dart';

import '../media_files_coodinator.dart';
import 'in_app_web_view_widget.dart';

class ViewFileWidget extends StatefulWidget {
  const ViewFileWidget({
    super.key,
    required this.url,
    this.title,
    this.showButtonFullScreen = false,
  });

  final String url;
  final String? title;
  final bool showButtonFullScreen;

  @override
  State<ViewFileWidget> createState() => _ViewFileWidgetState();
}

class _ViewFileWidgetState extends State<ViewFileWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InAppWebViewWidget(url: widget.url),
        if (widget.showButtonFullScreen)
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomRight,
              child: SafeArea(
                child: SizedBox(
                  child: IconButton(
                    onPressed: () {
                      context.viewFile(
                        url: widget.url,
                        title: widget.title,
                      );
                    },
                    icon: const Icon(Icons.fullscreen),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
