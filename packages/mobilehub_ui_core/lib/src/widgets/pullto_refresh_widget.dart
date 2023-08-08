import 'package:flutter/material.dart';
import 'package:mobilehub_core/mobilehub_core.dart';

import '../list/sliver/sliver_refresh_indicator_widget.dart';

class PullToRefreshWidget extends StatelessWidget {
  const PullToRefreshWidget({
    super.key,
    this.onRefresh,
    required this.slivers,
    this.offsetPadding = 0,
  });

  final Future<void> Function()? onRefresh;
  final List<Widget> slivers;
  final double offsetPadding;

  @override
  Widget build(BuildContext context) {
    if (onRefresh == null) {
      return CustomScrollView(
        slivers: slivers,
      );
    }

    if (isAndroid) {
      return RefreshIndicator(
        onRefresh: onRefresh!,
        child: CustomScrollView(
          slivers: slivers,
        ),
      );
    }

    return CustomScrollView(
      slivers: [
        SliverRefreshIndicatorWidget(
          onRefresh: onRefresh!,
        ),
        ...slivers,
      ],
    );
  }
}
