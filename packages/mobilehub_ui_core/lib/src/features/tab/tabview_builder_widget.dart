import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/decoration/tab_indicator_decoration.dart';

class TabviewBuilderWidget<T> extends StatefulWidget {
  const TabviewBuilderWidget({
    super.key,
    required this.tabsData,
    required this.tabBuilderItem,
    required this.tabView,
    this.heightTabview,
    this.footerBuilder,
    this.indexController,
    this.isTabDataScroll,
    this.paddingTabData,
    this.paddingContent = const EdgeInsets.only(bottom: 10, top: 25),
    this.initialTab = 0,
    this.isExpand = false,
    this.isUseTabbar = false,
    this.trailingTabbar,
    this.onTapItem,
  });

  final List<T> tabsData;
  final Widget Function(T tab, bool isSelected) tabBuilderItem;
  final double? heightTabview;
  final List<Widget> tabView;
  final Widget Function(T?)? footerBuilder;
  final ValueNotifier<int>? indexController;
  final bool? isTabDataScroll;
  final EdgeInsets? paddingTabData;
  final EdgeInsets paddingContent;
  final int initialTab;
  final bool isExpand;
  final bool isUseTabbar;
  final Widget Function(T?)? trailingTabbar;
  final FutureOr Function(T)? onTapItem;

  @override
  State<TabviewBuilderWidget<T>> createState() =>
      _TabviewBuilderWidgetState<T>();
}

class _TabviewBuilderWidgetState<T> extends State<TabviewBuilderWidget<T>> {
  T? _tabSelected;
  late final _pageController = PageController(initialPage: widget.initialTab);

  Future<void> _onTapSelected(int index) async {
    final canChange = await (widget.onTapItem?.call(widget.tabsData[index]) ??
        Future.value(true));
    if (canChange) {
      setState(() {
        _tabSelected = widget.tabsData[index];
      });
      _pageController.jumpToPage(index);
    }
  }

  @override
  void initState() {
    super.initState();
    _tabSelected = widget.tabsData[widget.initialTab];

    if (widget.indexController != null) {
      widget.indexController?.value = widget.initialTab;
    }
  }

  @override
  Widget build(BuildContext context) {
    final body = Container(
      height: widget.heightTabview,
      margin: widget.paddingContent,
      child: PageView(
        onPageChanged: (i) {
          if (widget.indexController != null) {
            widget.indexController?.value = i;
          }
        },
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: widget.tabView,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.isUseTabbar)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: DefaultTabController(
                    length: widget.tabsData.length,
                    child: TabBar(
                      indicator: TabIndicatorDecoration(
                        weight: 2,
                        width: 8,
                        color: const Color(0xff3C9DFC),
                      ),
                      tabs: widget.tabsData
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child:
                                  widget.tabBuilderItem(e, e == _tabSelected),
                            ),
                          )
                          .toList(),
                      labelStyle: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontSize: 16),
                      onTap: _onTapSelected,
                      padding: EdgeInsets.zero,
                      labelPadding: const EdgeInsets.symmetric(horizontal: 5),
                      unselectedLabelStyle:
                          Theme.of(context).textTheme.labelMedium,
                      labelColor: Colors.blue,
                      unselectedLabelColor: Colors.black,
                      isScrollable: true,
                      indicatorColor: const Color(0xff3C9DFC),
                    ),
                  ),
                ),
                if (widget.trailingTabbar != null)
                  widget.trailingTabbar!(_tabSelected),
              ],
            ),
          )
        else
          buildCtrlTabsData(),
        if (widget.heightTabview == null) Expanded(child: body) else body,
        if (widget.footerBuilder != null)
          widget.footerBuilder!.call(_tabSelected),
      ],
    );
  }

  Widget buildCtrlTabsData() {
    if (widget.isTabDataScroll ?? false) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: buildTabsData(),
      );
    }
    return buildTabsData();
  }

  Widget buildTabsData() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(
        widget.tabsData.length,
        (index) {
          final e = widget.tabsData[index];

          final child = Padding(
            padding: widget.paddingTabData ?? EdgeInsets.zero,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => _onTapSelected(index),
              child: IgnorePointer(
                ignoring: true,
                child: widget.tabBuilderItem(e, e == _tabSelected),
              ),
            ),
          );

          if (widget.isExpand) {
            return Expanded(child: child);
          }

          return child;
        },
      ),
    );
  }
}
