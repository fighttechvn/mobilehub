import 'package:flutter/material.dart';

import 'slide_animation/dot_slide_widget.dart';

const _heightWidget = 40.0;
const _heightLineSlide = 30.0;

class SlideAnimation extends StatefulWidget {
  const SlideAnimation({
    super.key,
    this.showDotValue = false,
    required this.value,
    this.onChanged,
  });

  final bool showDotValue;
  final double value;
  final void Function(double)? onChanged;

  @override
  State<SlideAnimation> createState() => _SlideAnimationState();
}

class _SlideAnimationState extends State<SlideAnimation> {
  double get _valueDefault => widget.value > 1
      ? 1
      : widget.value < 0
          ? 0
          : widget.value;

  var _maxWidth = 0.0;
  Offset _offset = Offset.zero;
  Size _size = Size.zero;

  final _globalKeyerKey = GlobalKey();
  late final _controller = ValueNotifier<double>(_maxWidth * _valueDefault);

  void _getOffset() {
    final box = context.findRenderObject() as RenderBox;
    final pos = box.localToGlobal(Offset.zero);
    _offset = Offset(-pos.dx, -pos.dy);
    _size = box.size;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getOffset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      key: _globalKeyerKey,
      builder: (_, boxConstraints) {
        _maxWidth = boxConstraints.maxWidth;
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          _controller.value = _maxWidth * _valueDefault;
        });

        var totalItem = (boxConstraints.maxWidth - 10) ~/ 14;
        if (totalItem % 2 == 0) {
          totalItem--;
        }

        return ClipRRect(
          borderRadius: BorderRadius.circular(_heightLineSlide),
          child: SizedBox(
            height: _heightWidget,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: _heightLineSlide,
                    decoration: BoxDecoration(
                      color: const Color(0xffFFD1BE),
                      borderRadius: BorderRadius.circular(_heightLineSlide),
                    ),
                  ),
                ),
                if (widget.showDotValue == false)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      height: _heightLineSlide,
                      width: boxConstraints.maxWidth,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: DotSlideWidget(countItem: totalItem),
                      ),
                    ),
                  ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ValueListenableBuilder<double>(
                    valueListenable: _controller,
                    builder: (_, value, ___) {
                      return Container(
                        height: _heightLineSlide,
                        width: value > 0 ? value : 0,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(_heightWidget),
                        ),
                      );
                    },
                  ),
                ),
                if (widget.showDotValue)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      height: _heightLineSlide,
                      width: boxConstraints.maxWidth,
                      child: Center(
                        child: DotSlideWidget(countItem: totalItem),
                      ),
                    ),
                  ),
                ValueListenableBuilder<double>(
                  valueListenable: _controller,
                  builder: (_, dx, ___) {
                    return Positioned(
                      left: dx - _heightWidget > 0 ? dx - _heightWidget : 0,
                      child: GestureDetector(
                        onHorizontalDragUpdate: (details) {
                          final offsetCurrent = details.globalPosition;

                          var valueCurrent = offsetCurrent.dx - _offset.dx;
                          if (valueCurrent > _size.width) {
                            valueCurrent = _size.width;
                          } else if (valueCurrent < 0) {
                            valueCurrent = 0;
                          }

                          _controller.value = valueCurrent;
                          widget.onChanged?.call(valueCurrent / _size.width);
                        },
                        child: Container(
                          height: _heightWidget,
                          width: _heightWidget,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            border: Border.all(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(_heightWidget),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
