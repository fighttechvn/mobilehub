import 'package:flutter/material.dart';

import '../../core/decoration/stepper_decoration.dart';

class StepperWidget<T> extends StatefulWidget {
  const StepperWidget({
    super.key,
    required this.items,
    this.onSelected,
    this.currentIndex = 0,
  });

  final List<ItemStepper<T>> items;
  final int currentIndex;
  final ValueChanged<T?>? onSelected;

  @override
  State<StepperWidget<T>> createState() => _StepperWidgetState<T>();
}

class _StepperWidgetState<T> extends State<StepperWidget<T>> {
  int? _indexSelected;

  void _onTapItem(ItemStepper<T> item, int index) {
    widget.onSelected?.call(item.data);
    setState(() {
      _indexSelected = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _indexSelected = widget.currentIndex;
  }

  @override
  void didUpdateWidget(covariant StepperWidget<T> oldWidget) {
    if (oldWidget.currentIndex != widget.currentIndex) {
      setState(() {
        _indexSelected = widget.currentIndex;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12),
      color: Colors.white,
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: const BoxDecoration(
                // boxShadow: [
                //   BoxShadow(
                //       color: AppColors.grey5,
                //       blurRadius: 3,
                //       spreadRadius: 1,
                //       offset: Offset(0, 3)),
                // ],
                ),
            child: Stack(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    widget.items.length,
                    (index) {
                      final item = widget.items[index];

                      return GestureDetector(
                        onTap: () => index == widget.currentIndex
                            ? _onTapItem(item, index)
                            : null,
                        child: Container(
                          height: 40,
                          padding: const EdgeInsets.only(left: 10, right: 30),
                          decoration: StepperDecoration(
                            showShadown: false,
                            color: _indexSelected == index
                                ? Theme.of(context).scaffoldBackgroundColor
                                : const Color(0xffF5F5F5),
                            isFirst: index == 0,
                            isLast: index == widget.items.length - 1,
                            isSelected: _indexSelected == index,
                          ),
                          child: Center(
                            child: Text(
                              item.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    color: index != _indexSelected
                                        ? const Color(0xFFBDBDBD)
                                        : const Color(0xFF287DB2),
                                  ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    widget.items.length,
                    (index) {
                      final item = widget.items[index];

                      return IgnorePointer(
                        ignoring: true,
                        child: GestureDetector(
                          child: Container(
                            height: 40,
                            padding: const EdgeInsets.only(left: 10, right: 30),
                            decoration: StepperDecoration(
                              isShowItemUnselected: false,
                              color: _indexSelected == index
                                  ? Theme.of(context).scaffoldBackgroundColor
                                  : const Color(0xffF5F5F5),
                              isFirst: index == 0,
                              isLast: index == widget.items.length - 1,
                              isSelected: _indexSelected == index,
                            ),
                            child: Center(
                              child: Text(
                                item.title,
                                style: index == _indexSelected
                                    ? Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                          color: Theme.of(context).primaryColor,
                                        )
                                    : const TextStyle(
                                        color: Colors.transparent,
                                      ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ItemStepper<T> {
  final T data;
  final String title;

  ItemStepper(this.data, this.title);
}
