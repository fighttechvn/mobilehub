import 'package:flutter/material.dart';

class GroupsWidget extends StatelessWidget {
  const GroupsWidget({
    super.key,
    required this.children,
    required this.name,
    this.shrinkWrapChild = true,
    this.paddingContent = const EdgeInsets.symmetric(vertical: 10),
    this.separator,
    this.backgroundColor,
    this.isMaxSizeHorizontal = true,
    this.alignment,
  });

  final String name;
  final List<Widget> children;
  final bool shrinkWrapChild;
  final EdgeInsets paddingContent;
  final Widget? separator;
  final Color? backgroundColor;
  final bool isMaxSizeHorizontal;
  final AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) {
    final bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: paddingContent,
      child: InputDecorator(
        decoration: InputDecoration(
          filled: true,
          fillColor:
              backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
          labelText: name,
          labelStyle: TextStyle(
            fontSize: 20,
            color: isDarkTheme ? Colors.white : Colors.black,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: isDarkTheme ? Colors.white : Colors.black,
              width: 1.5,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 0),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: shrinkWrapChild,
            itemBuilder: (context, index) {
              if (isMaxSizeHorizontal) {
                if (alignment != null) {
                  return Align(
                    alignment: alignment!,
                    child: children[index],
                  );
                }

                return children[index];
              }

              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (alignment != null)
                    Align(
                      alignment: alignment!,
                      child: children[index],
                    )
                  else
                    children[index],
                ],
              );
            },
            separatorBuilder: (context, index) =>
                separator ?? const SizedBox(height: 10),
            itemCount: children.length,
          ),
        ),
      ),
    );
  }
}
