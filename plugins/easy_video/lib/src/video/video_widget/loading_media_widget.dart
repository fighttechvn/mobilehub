import 'package:flutter/material.dart';

import '../../widgets/loading_widget.dart';

class LoadingMediaWidget extends StatelessWidget {
  final Color bgColor;

  const LoadingMediaWidget({
    super.key,
    this.bgColor = Colors.black38,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(3),
      ),
      height: 20,
      width: 20,
      padding: const EdgeInsets.all(2),
      child: const Center(
        child: FittedBox(fit: BoxFit.cover, child: LoadingWidget()),
      ),
    );
  }
}
