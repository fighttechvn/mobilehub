import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

const kExtentInfinite = 2000;
const kExtentDefault = 500;

mixin PagingMixin<T extends StatefulWidget> on State<T> {
  Future<void> onLoadmore();
  ScrollController get scrollController;

  bool get infiniteMode => false;

  bool get hasNext => true;

  bool get isLoadingData => false;

  Future<void> _onLoadmore() async {
    await onLoadmore();
  }

  void _handleLoadMoreData() {
    if (hasNext == false || isLoadingData) {
      return;
    }

    if (scrollController.position.extentBefore < 300) {
      return;
    }
    if (scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      return;
    }
    if (infiniteMode) {
      if (scrollController.position.extentAfter < kExtentInfinite) {
        _onLoadmore();
        return;
      }
    }
    if (scrollController.position.extentAfter < kExtentDefault) {
      _onLoadmore();
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        scrollController.addListener(_handleLoadMoreData);
      }
    });
  }

  @override
  void dispose() {
    scrollController.removeListener(_handleLoadMoreData);
    super.dispose();
  }
}
