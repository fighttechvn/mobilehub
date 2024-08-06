import 'package:flutter/material.dart';

import '../easy_file_preview_coodinator.dart';

class FullScreenWidget extends StatefulWidget {
  final Widget child;
  final bool showCloseButton;
  final bool showExpandButton;

  const FullScreenWidget({
    super.key,
    required this.child,
    this.showCloseButton = true,
    this.showExpandButton = true,
  });

  @override
  State<FullScreenWidget> createState() => _FullScreenWidgetState();
}

class _FullScreenWidgetState extends State<FullScreenWidget> {
  bool isFullScreen = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.showCloseButton
            ? SizedBox(
                height: MediaQuery.sizeOf(context).height,
                child: widget.child,
              )
            : widget.child,
        if (widget.showExpandButton)
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomRight,
              child: SafeArea(
                child: SizedBox(
                  child: IconButton(
                    onPressed: () {
                      context.startFullScreen(widget.child);
                      setState(() {
                        isFullScreen = !isFullScreen;
                      });
                    },
                    icon: const Icon(
                      Icons.fullscreen,
                    ),
                  ),
                ),
              ),
            ),
          ),
        if (widget.showCloseButton)
          Positioned(
            top: 0,
            right: 16,
            child: SafeArea(
              child: GestureDetector(
                onTap: Navigator.of(context).pop,
                child: Container(
                  height: 28,
                  width: 28,
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.all(2),
                  child: const FittedBox(
                    fit: BoxFit.contain,
                    child: Icon(
                      Icons.close_rounded,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
