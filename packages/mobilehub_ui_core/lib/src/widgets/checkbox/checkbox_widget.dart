// Copyright 2022 Fighttech.vn, Ltd. All rights reserved.

import 'package:flutter/material.dart';

typedef CheckboxBuilder<T> = Widget Function(bool isSelected, T data);

enum PositionRadio {
  start,
  end;

  bool get isStart => this == PositionRadio.start;
  bool get isEnd => this == PositionRadio.end;
}

class CheckBoxWidget<T> extends StatefulWidget {
  final double size;
  final Color borderColor;
  final bool isSelected;
  final bool hasUnselect;
  final Function(bool isSelected)? onSelected;
  final String? text;
  final Widget? textWidget;
  final Color? activeColor;
  final Color? inactiveColor;
  final CheckboxBuilder<T>? builder;
  final TextStyle? style;
  final T data;
  final bool expendTitle;
  final PositionRadio position;

  const CheckBoxWidget({
    Key? key,
    this.size = 22,
    this.borderColor = Colors.grey,
    this.isSelected = false,
    this.hasUnselect = false,
    this.onSelected,
    this.text,
    this.activeColor,
    this.inactiveColor,
    this.builder,
    this.style,
    required this.data,
    this.textWidget,
    this.expendTitle = false,
    this.position = PositionRadio.start,
  }) : super(key: key);

  @override
  State<CheckBoxWidget<T>> createState() => _CheckBoxWidgetState<T>();
}

class _CheckBoxWidgetState<T> extends State<CheckBoxWidget<T>> {
  late bool _isSelected;

  @override
  void initState() {
    _isSelected = widget.isSelected;

    super.initState();
  }

  @override
  void didUpdateWidget(covariant CheckBoxWidget<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected != oldWidget.isSelected) {
      _isSelected = widget.isSelected;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: const ValueKey('checkbox_widget_key'),
      onTap: () {
        if (_isSelected == true && widget.hasUnselect == false) {
          return;
        }

        setState(() {
          _isSelected = !_isSelected;
        });
        widget.onSelected?.call(_isSelected);
      },
      child: Container(
        color: Colors.transparent,
        child: (widget.text?.isNotEmpty ?? false) || widget.textWidget != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.position.isStart) ...[
                    _buildCheckBoxCustom(),
                    const SizedBox(width: 10),
                  ],
                  Flexible(
                    fit: widget.expendTitle ? FlexFit.tight : FlexFit.loose,
                    child: widget.textWidget ??
                        ((widget.text?.isNotEmpty ?? false)
                            ? Tooltip(
                                message: widget.text,
                                child: Text(
                                  widget.text!,
                                  style: widget.style,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            : const SizedBox()),
                  ),
                  if (widget.position.isEnd) ...[
                    const SizedBox(width: 10),
                    _buildCheckBoxCustom(),
                  ],
                ],
              )
            : _buildCheckBoxCustom(),
      ),
    );
  }

  Widget _buildCheckBoxCustom() {
    if (widget.builder != null) {
      return widget.builder!.call(_isSelected, widget.data);
    }

    return Container(
      key: const ValueKey('checkbox_widget_container_key'),
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        border: _isSelected ? null : Border.all(color: widget.borderColor),
        color: _isSelected
            ? (widget.activeColor ?? Theme.of(context).colorScheme.secondary)
            : (widget.inactiveColor ??
                Theme.of(context).scaffoldBackgroundColor),
        borderRadius: BorderRadius.circular(
          widget.size / 2,
        ),
      ),
    );
  }
}
