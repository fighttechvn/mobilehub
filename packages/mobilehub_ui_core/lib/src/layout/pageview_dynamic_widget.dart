import 'package:flutter/material.dart';

const _extentSizeForBottom = 20.0;

class PageViewDynamicWidget extends StatefulWidget {
  const PageViewDynamicWidget({
    super.key,
    required this.pageController,
    required this.children,
    this.heightDefault = 200.0,
  });

  final PageController pageController;
  final List<Widget> children;
  final double heightDefault;

  @override
  State<PageViewDynamicWidget> createState() => _PageViewDynamicWidgetState();
}

class _PageViewDynamicWidgetState extends State<PageViewDynamicWidget> {
  final _heightOfTab = [];
  int _indexCurrent = 0;
  late final _sizePageView = ValueNotifier(_heightTitlePageView);

  double get _heightTitlePageView =>
      _heightOfTab.isNotEmpty ? _heightOfTab.first : widget.heightDefault;

  void _onChangePageView() {
    _indexCurrent = widget.pageController.page?.toInt() ?? 0;
    _sizePageView.value = _heightOfTab[_indexCurrent] ?? _heightTitlePageView;
  }

  @override
  void initState() {
    super.initState();
    widget.pageController.addListener(_onChangePageView);

    for (var i = 0; i < widget.children.length; i++) {
      _heightOfTab.add(_heightTitlePageView);
    }
  }

  @override
  void dispose() {
    widget.pageController.removeListener(_onChangePageView);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: _sizePageView,
      builder: (_, heightPageView, __) {
        return SizedBox(
          height: heightPageView,
          child: PageView(
            controller: widget.pageController,
            children: List.generate(
              widget.children.length,
              (index) {
                final item = widget.children[index];
                return _DetectorSizeChildWidget(
                  onGetSize: (p0, p1) {
                    _heightOfTab[index] = p0.height + _extentSizeForBottom;
                    if (index == _indexCurrent) {
                      _sizePageView.value =
                          _heightOfTab[index] ?? _heightTitlePageView;
                    }
                  },
                  child: item,
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _DetectorSizeChildWidget extends StatefulWidget {
  const _DetectorSizeChildWidget({
    required this.child,
    required this.onGetSize,
  });

  final Widget child;
  final void Function(Size, BuildContext) onGetSize;

  @override
  State<_DetectorSizeChildWidget> createState() =>
      _DetectorSizeChildWidgetState();
}

class _DetectorSizeChildWidgetState extends State<_DetectorSizeChildWidget> {
  GlobalKey globalKeyCenterButton = GlobalKey();

  void _getSize() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final RenderBox renderBox =
          globalKeyCenterButton.currentContext!.findRenderObject() as RenderBox;
      widget.onGetSize(renderBox.size, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, __) {
      _getSize();

      return SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SizedBox(
          key: globalKeyCenterButton,
          child: widget.child,
        ),
      );
    });
  }
}
