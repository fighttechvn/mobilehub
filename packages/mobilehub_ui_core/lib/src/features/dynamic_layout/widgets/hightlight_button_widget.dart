import 'package:flutter/material.dart';

class InsightsMenuWidget extends StatelessWidget {
  const InsightsMenuWidget({
    super.key,
    required this.backgroundColor,
    required this.child,
    this.height,
    this.minHeight,
    this.width,
  });

  final Color backgroundColor;
  final Widget child;
  final double? height;
  final double? minHeight;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          minHeight != null ? BoxConstraints(minHeight: minHeight!) : null,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: backgroundColor,
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A358CFF),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      width: width,
      height: height,
      padding: const EdgeInsets.only(
        left: 8,
        top: 20,
        right: 8,
        bottom: 22,
      ),
      child: child,
    );
  }
}
