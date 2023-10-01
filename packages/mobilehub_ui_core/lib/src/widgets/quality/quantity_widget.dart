import 'package:flutter/material.dart';

class QuantityWidget extends StatefulWidget {
  const QuantityWidget({
    super.key,
    this.controller,
    this.max,
    this.min = 1,
    this.showTitle = true,
    this.showLabel = true,
    this.isColorTransparent = false,
    this.disable = false,
  });

  final ValueNotifier<int>? controller;
  final int? max;
  final int min;
  final bool? showTitle;
  final bool? showLabel;
  final bool? isColorTransparent;
  final bool? disable;

  @override
  State<QuantityWidget> createState() => _QuantityWidgetState();
}

class _QuantityWidgetState extends State<QuantityWidget> {
  late ValueNotifier<int> _quantityCtr;

  @override
  void initState() {
    _quantityCtr = widget.controller ?? ValueNotifier<int>(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                                _quantityCtr.value -= 1;
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
                    ),
                    child: const Center(
                      child: Text(
                        '-',
                        style: TextStyle(height: 1),
                      ),
                    ),
                  ),
                ),
                Container(
                  constraints:
                      const BoxConstraints(minWidth: 38, maxHeight: 38),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        width: 1,
                        color: Color(0xFFF0F0F0),
                      ),
                      bottom: BorderSide(
                        width: 1,
                        color: Color(0xFFF0F0F0),
                      ),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '${_quantityCtr.value}',
                      style: const TextStyle(fontSize: 14, height: 1),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: widget.disable ?? false
                      ? null
                      : (widget.max != null &&
                              _quantityCtr.value >= widget.max!)
                          ? null
                          : () {
                              if (widget.max != null) {
                                if (_quantityCtr.value < widget.max!) {
                                  _quantityCtr.value += 1;
                                }
                              } else {
                                _quantityCtr.value += 1;
                              }
                            },
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: widget.isColorTransparent ?? true
                          ? Colors.transparent
                          : (widget.max != null &&
                                  _quantityCtr.value >= widget.max!)
                              ? Colors.grey
                              : Theme.of(context).primaryColor.withOpacity(.8),
                      border: Border.all(
                        width: 1,
                        color: const Color(0xFFF0F0F0),
                      ),
                    ),
                    child: const Center(
                      child: Text('+', style: TextStyle(height: 1)),
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
