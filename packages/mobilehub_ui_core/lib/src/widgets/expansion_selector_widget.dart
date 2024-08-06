import 'package:flutter/material.dart';

const _sizeRemoveWhenSelectItem = 10.0;
const _sizeItem = 30.0;

class ExpansionSelectorWidget<T> extends StatefulWidget {
  final bool isExpend;
  final Duration duration;
  final Widget Function(T?, bool) builderTitle;
  final List<T> items;
  final Widget Function(T) builderItem;
  final void Function(T)? onTapItem;
  final void Function(T?)? onTapTitle;
  final T? value;

  const ExpansionSelectorWidget({
    super.key,
    required this.builderTitle,
    this.isExpend = false,
    this.duration = const Duration(milliseconds: 300),
    required this.items,
    required this.builderItem,
    this.onTapItem,
    this.onTapTitle,
    this.value,
  });

  @override
  State<ExpansionSelectorWidget<T>> createState() =>
      _ExpansionSelectorWidgetState<T>();
}

class _ExpansionSelectorWidgetState<T> extends State<ExpansionSelectorWidget<T>>
    with SingleTickerProviderStateMixin {
  final _keyWidget = GlobalKey();
  late AnimationController _controller;
  late Animation<double> _animation;
  double? _heightSetItem;
  late T? _selectedValue = widget.value;
  late var _isExpend = widget.isExpend;

  void _setHeight() {
    if (_heightSetItem == null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        final Size? sizeWidget = _keyWidget.currentContext?.size;

        if (sizeWidget != null) {
          _heightSetItem = sizeWidget.height;
        }
      });
    }
  }

  void _onTapItem(T item) {
    widget.onTapItem?.call(item);

    _controller.reverse();

    setState(() {
      if (_selectedValue == null && _heightSetItem != null) {
        _heightSetItem = _heightSetItem! - _sizeRemoveWhenSelectItem;
      }

      _isExpend = false;
      _selectedValue = item;
    });
  }

  void _onTapAction() {
    if ([AnimationStatus.dismissed].contains(_controller.status)) {
      _isExpend = true;
      _controller.forward();
    } else {
      _isExpend = false;
      _controller.reverse();
    }

    setState(() {});

    widget.onTapTitle?.call(_selectedValue);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _animation = Tween<double>(
      begin: widget.isExpend ? 1.0 : 0.0,
      end: widget.isExpend ? 0.0 : 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
        reverseCurve: Curves.easeOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ExpansionSelectorWidget<T> oldWidget) {
    if (_selectedValue != widget.value) {
      _selectedValue = widget.value;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    _setHeight();

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5)
          .copyWith(top: 0),
      width: double.infinity,
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              final height = _heightSetItem ?? 0;
              final dy = height - _animation.value * height;

              return Transform.translate(
                offset: Offset(
                  0,
                  -dy,
                ),
                child: Container(
                  padding: EdgeInsets.only(
                    top: _isExpend
                        ? (_selectedValue != null ? _sizeItem : 10)
                        : _sizeItem,
                    bottom: _isExpend ? 0 : 8,
                  ),
                  height: _heightSetItem == null
                      ? (widget.isExpend ? null : 0)
                      : _heightSetItem! * _animation.value,
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: child,
                  ),
                ),
              );
            },
            child: SizedBox(
              key: _keyWidget,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  widget.items.length,
                  (index) {
                    final item = widget.items[index];

                    if (item == _selectedValue) {
                      return const SizedBox();
                    }

                    return GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () => _onTapItem(item),
                      child: Container(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        width: double.infinity,
                        child: widget.builderItem(item),
                      ),
                    );
                  },
                )..add(
                    const SizedBox(height: 10),
                  ),
              ),
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: _onTapAction,
            child: Container(
              color: Theme.of(context).colorScheme.surface,
              width: double.infinity,
              padding: const EdgeInsets.only(top: 10, bottom: 8),
              child: widget.builderTitle(_selectedValue, _isExpend),
            ),
          ),
          Positioned.directional(
            textDirection: Directionality.of(context),
            end: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ExpandIcon(
                onPressed: (bool value) => _onTapAction(),
                isExpanded: _isExpend,
                padding: const EdgeInsets.only(top: 20, left: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
