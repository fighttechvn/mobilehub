import 'package:flutter/material.dart';

import 'widgets/full_screen_widget.dart';

extension EasyFilePreviewCoodinator on BuildContext {
  Future<T?> startFullScreen<T>(Widget child) {
    return Navigator.of(this).push(MaterialPageRoute(
        builder: (context) => Material(
                child: Center(
                    child: FullScreenWidget(
              showExpandButton: false,
              child: child,
            )))));
  }
}
