import 'package:flutter/material.dart';

import 'checkbox_widget.dart';

typedef GroupCheckBoxBuilder<T> = Widget Function(
  int index,
  CheckBoxWidget<T> item,
  BoxConstraints constraints,
  bool isSelected,
  T data,
);

class GroupCheckBoxWidget<T> extends StatefulWidget {
  const GroupCheckBoxWidget({
    Key? key,
    this.onSelected,
    this.defaultValue,
    required this.values,
    this.numberOfRow,
    this.spacing = 8,
    this.error,
    this.isRadioType = false,
    this.checkBoxbuilder,
    this.groupCheckBoxBuilder,
    this.direction = Axis.horizontal,
    this.expendTitle = false,
    this.position = PositionRadio.start,
  })  : builderTitle = null,
        super(key: key);

  const GroupCheckBoxWidget.custom({
    Key? key,
    this.onSelected,
    this.defaultValue,
    required this.values,
    this.numberOfRow,
    this.spacing = 8,
    this.error,
    this.isRadioType = false,
    this.checkBoxbuilder,
    this.groupCheckBoxBuilder,
    this.direction = Axis.horizontal,
    required this.builderTitle,
    this.expendTitle = false,
    this.position = PositionRadio.start,
  }) : super(key: key);

  final ValueChanged<T?>? onSelected;
  final T? defaultValue;
  final List<T> values;
  final int? numberOfRow;
  final double spacing;
  final Widget? error;
  final bool isRadioType;
  final CheckboxBuilder<T>? checkBoxbuilder;
  final GroupCheckBoxBuilder<T>? groupCheckBoxBuilder;
  final Axis direction;
  final Widget Function(T data, bool isSelected)? builderTitle;
  final bool expendTitle;
  final PositionRadio position;

  @override
  State<GroupCheckBoxWidget<T>> createState() => _GroupCheckBoxWidgetState();
}

class _GroupCheckBoxWidgetState<T> extends State<GroupCheckBoxWidget<T>> {
  T? _selectedValue;

  void _onSelected(bool isSelected, T? value) {
    setState(() {
      if (isSelected) {
        _selectedValue = value;
        widget.onSelected?.call(_selectedValue);
      } else {
        _selectedValue = null;
        widget.onSelected?.call(null);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.defaultValue;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        if (widget.numberOfRow != null) {
          return GridView.builder(
            shrinkWrap: true,
            itemCount: widget.values.length,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.numberOfRow!,
              childAspectRatio: 16 / widget.numberOfRow!,
              crossAxisSpacing: widget.spacing,
              mainAxisSpacing: widget.spacing,
            ),
            itemBuilder: (context, index) {
              final item = widget.values.elementAt(index);
              final isSelected = _selectedValue == item;
              final titleWidget = Tooltip(
                message: item.toString(),
                child: widget.builderTitle?.call(item, isSelected) ??
                    Text(
                      item.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
              );

              final widgetItem = CheckBoxWidget<T>(
                position: widget.position,
                expendTitle: widget.expendTitle,
                textWidget: Expanded(child: titleWidget),
                isSelected: isSelected,
                hasUnselect: widget.isRadioType == false,
                onSelected: (bool isSelected) => _onSelected(isSelected, item),
                builder: widget.checkBoxbuilder,
                data: item,
              );
              if (widget.groupCheckBoxBuilder != null) {
                return GestureDetector(
                  onTap: () => _onSelected(isSelected, item),
                  behavior: HitTestBehavior.translucent,
                  child: widget.groupCheckBoxBuilder!.call(
                    index,
                    widgetItem,
                    constraints,
                    isSelected,
                    item,
                  ),
                );
              }
              return widgetItem;
            },
          );
        }

        final items = List.generate(widget.values.length, (index) {
          final item = widget.values.toList()[index];
          final isSelected = _selectedValue == item;
          final titleWidget = widget.builderTitle?.call(item, isSelected) ??
              Text(item.toString());

          final widgetCheckBox = CheckBoxWidget<T>(
            textWidget: titleWidget,
            data: item,
            position: widget.position,
            expendTitle: widget.expendTitle,
            isSelected: _selectedValue == item,
            hasUnselect: widget.isRadioType == false,
            onSelected: (bool isSelected) => _onSelected(isSelected, item),
            builder: widget.checkBoxbuilder,
          );

          if (widget.groupCheckBoxBuilder != null) {
            return GestureDetector(
              onTap: () => _onSelected(isSelected, item),
              behavior: HitTestBehavior.translucent,
              child: widget.groupCheckBoxBuilder!.call(
                index,
                widgetCheckBox,
                constraints,
                isSelected,
                item,
              ),
            );
          }

          return widgetCheckBox;
        });

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (widget.direction == Axis.vertical)
              ...items
                  .expand(
                    (element) => [element, SizedBox(height: widget.spacing)],
                  )
                  .toList()
                ..removeLast()
            else
              Wrap(
                spacing: widget.spacing,
                runSpacing: widget.spacing,
                direction: widget.direction,
                alignment: WrapAlignment.spaceBetween,
                children: items,
              ),
            if (widget.error != null) widget.error!,
          ],
        );
      },
    );
  }
}
