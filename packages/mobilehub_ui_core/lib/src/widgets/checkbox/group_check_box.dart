import 'package:flutter/material.dart';

import 'checkbox_widget.dart';
import 'group_check_box_widget.dart';

class GroupCheckBox<T> extends StatelessWidget {
  final ValueChanged<T?>? onSelected;
  final List<T> values;
  final T? defaultValue;
  final bool showDivider;
  final Widget Function(T data, bool isSelected) builderTitle;

  const GroupCheckBox({
    super.key,
    required this.values,
    this.onSelected,
    this.defaultValue,
    this.showDivider = true,
    required this.builderTitle,
  });

  @override
  Widget build(BuildContext context) {
    return GroupCheckBoxWidget<T>(
      spacing: 0,
      defaultValue: defaultValue,
      direction: Axis.vertical,
      values: values,
      onSelected: onSelected,
      checkBoxbuilder: (bool isSelected, T data) {
        return RadioButtonWidget(isSelected: isSelected);
      },
      groupCheckBoxBuilder: (
        int index,
        CheckBoxWidget item,
        BoxConstraints constraints,
        bool isSelected,
        T data,
      ) {
        BoxBorder? divider;
        if (showDivider == true) {
          divider = index < values.length - 1
              ? const Border(
                  bottom: BorderSide(width: 0.5, color: Colors.white),
                )
              : null;
        }
        return Container(
          width: constraints.maxWidth,
          decoration: BoxDecoration(border: divider),
          child: item,
        );
      },
    );
  }
}

class RadioButtonWidget extends StatelessWidget {
  final bool isSelected;

  const RadioButtonWidget({
    super.key,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? const Color(0xffFFBD11) : const Color(0xFF696969),
        ),
      ),
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Container(
        decoration: isSelected
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xffFFBD11),
              )
            : null,
        margin: const EdgeInsets.all(6),
      ),
    );
  }
}
