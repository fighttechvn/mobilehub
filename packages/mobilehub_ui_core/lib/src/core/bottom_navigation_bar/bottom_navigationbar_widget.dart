import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final List<Widget> children;
  final BoxDecoration? boxDecoration;
  final Color? backgroundColor;
  final double? minimumPadding;

  const BottomNavigationBarWidget({
    Key? key,
    required this.children,
    this.boxDecoration,
    this.backgroundColor,
    this.minimumPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDecoration ??
          BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
            color: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
          ),
      child: SafeArea(
        minimum: EdgeInsets.all(minimumPadding ?? 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
    );
  }
}
