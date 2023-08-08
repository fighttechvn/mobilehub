import 'package:flutter/material.dart';

class SliverAppbarCustom extends StatefulWidget {
  const SliverAppbarCustom({
    super.key,
    required this.backgroundBuilder,
    required this.titleBuilder,
    this.expandedFlexibleSpaceRatio = 375.0 / 240.0,
    this.toolbarHeight = kToolbarHeight,
    this.titleSpacing = 16,
    this.elevation = 0,
    this.backgroundCollapseMode = CollapseMode.pin,
  });

  final Widget Function(BuildContext context, double scale) backgroundBuilder;
  final Widget Function(BuildContext context, double scale) titleBuilder;

  final double toolbarHeight;

  /// the horizontal padding space of title
  /// [SliverAppBar.titleSpacing]
  final double titleSpacing;

  /// the ratio of flexibleSpace when it expanded to max size
  final double expandedFlexibleSpaceRatio;
  final double elevation;
  final CollapseMode backgroundCollapseMode;
  @override
  State<SliverAppbarCustom> createState() => _SliverAppbarCustomState();
}

class _SliverAppbarCustomState extends State<SliverAppbarCustom> {
  final scaleValue = ValueNotifier<double>(1);

  @override
  Widget build(BuildContext context) {
    final mediaData = MediaQuery.of(context);
    final expandedHeight =
        mediaData.size.width / widget.expandedFlexibleSpaceRatio;
    return SliverAppBar(
      backgroundColor: Colors.white,
      expandedHeight: expandedHeight,
      toolbarHeight: widget.toolbarHeight + mediaData.padding.top,
      primary: false,
      pinned: true,
      stretch: true,
      elevation: widget.elevation,
      automaticallyImplyLeading: false,
      titleSpacing: widget.titleSpacing,
      title: ValueListenableBuilder<double>(
        valueListenable: scaleValue,
        builder: (context, scale, _) {
          return Padding(
            padding: EdgeInsets.only(top: mediaData.padding.top),
            child: widget.titleBuilder(
              context,
              scale,
            ),
          );
        },
      ),
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          final scale = constraints.maxHeight / expandedHeight;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            scaleValue.value = scale;
          });
          return FlexibleSpaceBar(
            expandedTitleScale: 1,
            collapseMode: widget.backgroundCollapseMode,
            background: widget.backgroundBuilder(
              context,
              scale,
            ),
          );
        },
      ),
    );
  }
}
