import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String? label;
  final double? borderRadius;
  final TextStyle? textStyleLabel;
  final Function()? onPressed;
  final double? width;
  final double height;
  final Widget? child;
  final Color? color;
  final EdgeInsetsGeometry? padding;

  const ButtonWidget({
    Key? key,
    this.label,
    this.onPressed,
    this.borderRadius,
    this.textStyleLabel,
    this.width,
    this.height = 40,
    this.child,
    this.color,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(20),
            spreadRadius: 10,
            blurRadius: 20,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: color ?? Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 30),
          ),
        ),
        child: Container(
          padding: padding,
          width: width ?? double.infinity,
          height: height,
          child: child ??
              Center(
                child: Text(
                  label!,
                  style: textStyleLabel,
                ),
              ),
        ),
      ),
    );
  }
}
