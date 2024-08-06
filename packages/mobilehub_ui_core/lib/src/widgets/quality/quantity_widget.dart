import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobilehub_core/mobilehub_core.dart';

class QuantityWidget extends StatefulWidget {
  const QuantityWidget({
    super.key,
    this.controller,
    this.max = 99,
    this.min = 1,
    this.showTitle = true,
    this.showLabel = true,
    this.isColorTransparent = false,
    this.disable = false,
    this.radius = 0,
    this.value,
    this.onChanged,
  });

  final ValueNotifier<int>? controller;
  final int max;
  final int min;
  final bool? showTitle;
  final bool? showLabel;
  final bool? isColorTransparent;
  final bool? disable;
  final double radius;
  final int? value;
  final void Function(int)? onChanged;

  @override
  State<QuantityWidget> createState() => _QuantityWidgetState();
}

class _QuantityWidgetState extends State<QuantityWidget> {
  late ValueNotifier<int> _quantityCtr;
  final String _tagDebound = UniqueKey().toString();
  final TextEditingController _controller = TextEditingController();
  final _focusNode = FocusNode();

  int _mathSize(int max) {
    var valueCount = max * 1.0;
    var countSize = 1;

    while (valueCount >= 1) {
      valueCount /= 10;

      if (valueCount >= 1) {
        countSize += 1;
      }
    }

    // min is 2
    if (countSize == 1) {
      countSize = 2;
    }

    return countSize;
  }

  void _updateValueController(int value) {
    if (value > widget.max) {
      _controller.text = widget.max.toString();
    } else if (value < widget.min) {
      _controller.text = widget.min.toString();
    } else {
      _controller.text = value.toString();
    }

    widget.onChanged?.call(int.tryParse(_controller.text) ?? 0);
  }

  void _updateValueNotify(int value) {
    if (value > widget.max) {
      _quantityCtr.value = widget.max;
    } else if (value < widget.min) {
      _quantityCtr.value = widget.min;
    } else {
      _quantityCtr.value = value;
    }
    widget.onChanged?.call(_quantityCtr.value);
  }

  void _listenerFocusNode() {
    if (_focusNode.hasFocus == false) {
      final valueQuantity = int.tryParse(_controller.text);

      if (valueQuantity != null) {
        _updateValueNotify(valueQuantity);
      } else {
        _updateValueController(_quantityCtr.value);
      }
    }
  }

  @override
  void initState() {
    final defaultValue = widget.value ?? 1;
    _quantityCtr = widget.controller ?? ValueNotifier<int>(defaultValue);
    _controller.text =
        widget.controller?.value.toString() ?? defaultValue.toString();
    _focusNode.addListener(_listenerFocusNode);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    _focusNode.removeListener(_listenerFocusNode);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeTextField = 10.0 * _mathSize(widget.max) + 18;

    return AnimatedBuilder(
      animation: _quantityCtr,
      builder: (context, snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (widget.showTitle ?? true) ...[
              Text(
                'Choose a quantity',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 20),
            ],
            Row(
              children: [
                if (widget.showLabel ?? true) ...[
                  const Text('Quantity'),
                  const SizedBox(width: 20),
                ],
                GestureDetector(
                  onTap: widget.disable ?? false
                      ? null
                      : _quantityCtr.value <= widget.min
                          ? null
                          : () {
                              if (_quantityCtr.value > 0) {
                                final newValue = _quantityCtr.value - 1;
                                _updateValueNotify(newValue);
                                _updateValueController(newValue);
                              }
                            },
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: widget.isColorTransparent ?? true
                          ? Colors.transparent
                          : _quantityCtr.value <= widget.min
                              ? Colors.grey
                              : Theme.of(context).primaryColor,
                      border: Border.all(
                        width: 1,
                        color: const Color(0xFFF0F0F0),
                      ),
                      borderRadius: BorderRadius.circular(widget.radius),
                    ),
                    child: const Center(
                      child: Icon(
                        CupertinoIcons.minus,
                        size: 18,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(2),
                  constraints:
                      BoxConstraints(maxWidth: sizeTextField, maxHeight: 38),
                  child: TextFormField(
                    controller: _controller,
                    focusNode: _focusNode,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      EasyDebounce.debounce(
                        _tagDebound,
                        const Duration(milliseconds: 400),
                        () {
                          if (value.isNotEmpty) {
                            final valueQuantity = int.tryParse(value);

                            if (valueQuantity != null) {
                              _updateValueNotify(valueQuantity);
                              _updateValueController(valueQuantity);
                            } else {
                              _updateValueController(_quantityCtr.value);
                            }
                          }
                        },
                      );
                    },
                  ),
                ),
                GestureDetector(
                  onTap: widget.disable ?? false
                      ? null
                      : (_quantityCtr.value >= widget.max)
                          ? null
                          : () {
                              final newValue = _quantityCtr.value + 1;
                              _updateValueNotify(newValue);
                              _updateValueController(newValue);
                            },
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: widget.isColorTransparent ?? true
                          ? Colors.transparent
                          : (_quantityCtr.value >= widget.max)
                              ? Colors.grey
                              : Theme.of(context).primaryColor.withOpacity(.8),
                      border: Border.all(
                        width: 1,
                        color: const Color(0xFFF0F0F0),
                      ),
                      borderRadius: BorderRadius.circular(widget.radius),
                    ),
                    child: const Center(
                      child: Icon(
                        CupertinoIcons.add,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
