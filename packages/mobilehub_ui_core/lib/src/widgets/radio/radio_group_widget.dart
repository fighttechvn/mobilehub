import 'package:flutter/material.dart';

typedef DisplayValueBuilder<T> = Widget Function(
  BuildContext context,
  T value,
  int index,
);

class RadioGroupWidget<T> extends StatefulWidget {
  const RadioGroupWidget({
    Key? key,
    required this.value,
    required this.groupValue,
    this.onChanged,
    this.titleBuilder,
    this.subtitleBuilder,
    this.leadingBuilder,
    this.spacing = 8.0,
    this.radius = 8.0,
    this.borderColor,
    this.borderColorDefault,
    this.backgroundColor,
    this.padding,
    this.contentPadding,
    this.hasAlertWhenCodAndNotPdone = false,
    this.itemIsLeft = false,
    this.enableBorderItem = true,
  }) : super(key: key);

  final T? value;
  final List<T> groupValue;
  final ValueChanged<T?>? onChanged;
  final DisplayValueBuilder<T>? titleBuilder;
  final DisplayValueBuilder<T>? subtitleBuilder;
  final DisplayValueBuilder<T>? leadingBuilder;

  /// Item
  final bool enableBorderItem;
  final bool itemIsLeft;

  // Decoration
  final double spacing;
  final double radius;
  final Color? borderColor;
  final Color? borderColorDefault;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? contentPadding;

  // logic app
  final bool hasAlertWhenCodAndNotPdone;

  @override
  State<RadioGroupWidget<T>> createState() => _RadioGroupWidgetState<T>();
}

class _RadioGroupWidgetState<T> extends State<RadioGroupWidget<T>> {
  late T? _currentValue;

  double get _spacing => widget.spacing;

  double get _radius => widget.radius;

  Color get _borderColor =>
      widget.borderColor ?? Theme.of(context).primaryColor;

  Color get _borderColorDefault =>
      widget.borderColorDefault ?? Colors.transparent;

  Color? get _backgroundColor =>
      widget.backgroundColor ?? Theme.of(context).listTileTheme.tileColor;

  EdgeInsetsGeometry get _padding =>
      widget.padding ?? const EdgeInsets.symmetric(horizontal: 16.0);

  EdgeInsetsGeometry get _contentPadding =>
      widget.contentPadding ?? const EdgeInsets.symmetric(horizontal: 16.0);

  bool get hasAlert => widget.hasAlertWhenCodAndNotPdone;

  void _onChanged(T? value) {
    setState(() {
      _currentValue = value;
    });
    widget.onChanged?.call(value);
  }

  @override
  void initState() {
    super.initState();
    _currentValue = widget.value;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _currentValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: _padding,
      primary: false,
      itemBuilder: (BuildContext context, int index) {
        final T value = widget.groupValue[index];

        return DecoratedBox(
          decoration: widget.enableBorderItem == false
              ? const BoxDecoration()
              : BoxDecoration(
                  color: hasAlert
                      ? const Color.fromRGBO(217, 36, 36, 0.1)
                      : _backgroundColor,
                  border: Border.all(
                    color: _currentValue == value
                        ? (hasAlert ? const Color(0xffD92424) : _borderColor)
                        : _borderColorDefault,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(_radius),
                ),
          child: RadioListTile<T?>(
            value: value,
            controlAffinity: widget.itemIsLeft == true
                ? ListTileControlAffinity.leading
                : ListTileControlAffinity.trailing,
            groupValue: _currentValue,
            onChanged: _onChanged,
            secondary: widget.leadingBuilder?.call(context, value, index),
            title: widget.titleBuilder?.call(context, value, index),
            subtitle: widget.subtitleBuilder?.call(context, value, index),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_radius),
            ),
            tileColor: _backgroundColor,
            contentPadding: _contentPadding,
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: _spacing);
      },
      itemCount: widget.groupValue.length,
      shrinkWrap: true,
    );
  }
}
