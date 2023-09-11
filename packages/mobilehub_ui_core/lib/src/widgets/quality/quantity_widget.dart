import 'package:flutter/material.dart';

class QuantityWidget extends StatefulWidget {
  const QuantityWidget({
    super.key,
    this.controller,
    this.max,
    this.min = 1,
  });

  final ValueNotifier<int>? controller;
  final int? max;
  final int min;

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
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(10),
      child: AnimatedBuilder(
        animation: _quantityCtr,
        builder: (context, snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Choose a quantity',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text('Quantity'),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: _quantityCtr.value <= widget.min
                        ? null
                        : () {
                            if (_quantityCtr.value > 0) {
                              _quantityCtr.value -= 1;
                            }
                          },
                    child: Container(
                      color: _quantityCtr.value <= widget.min
                          ? Colors.grey
                          : Theme.of(context).primaryColor,
                      width: 30,
                      height: 30,
                      child: const Center(child: Text('-')),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${_quantityCtr.value}'),
                  ),
                  GestureDetector(
                    onTap: (widget.max != null &&
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
                      color: (widget.max != null &&
                              _quantityCtr.value >= widget.max!)
                          ? Colors.grey
                          : Theme.of(context).primaryColor.withOpacity(.8),
                      width: 30,
                      height: 30,
                      child: const Center(child: Text('+')),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
