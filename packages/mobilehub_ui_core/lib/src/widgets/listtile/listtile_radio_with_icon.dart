import 'package:flutter/material.dart';

class ListTileRadioWithIcon extends StatelessWidget {
  final Widget? leading;
  final IconData? iconData;
  final String title;
  final String? subTitle;
  final VoidCallback onTap;
  final Function(dynamic)? onChanged;
  final dynamic value;
  final dynamic groupValue;

  const ListTileRadioWithIcon({
    super.key,
    this.leading,
    this.iconData,
    required this.title,
    this.subTitle,
    required this.onTap,
    this.onChanged,
    this.value,
    this.groupValue,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: leading ??
          Icon(
            iconData,
            color: Colors.black,
            size: 22,
          ),
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: subTitle == null
          ? null
          : Text(
              subTitle!,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: const Color(0xffA1A1A1)),
            ),
      dense: true,
      minLeadingWidth: 0,
      minVerticalPadding: 0,
      horizontalTitleGap: 12,
      onTap: onTap,
      trailing: Radio(
        value: value,
        onChanged: onChanged,
        groupValue: groupValue,
        fillColor: MaterialStateColor.resolveWith(
          (states) => Theme.of(context).primaryColor,
        ), //
      ),
    );
  }
}
