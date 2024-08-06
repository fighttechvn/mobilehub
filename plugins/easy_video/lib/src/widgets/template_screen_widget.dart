import 'package:flutter/material.dart';

class TemplateScreenWidget extends StatelessWidget {
  final String? title;
  final Widget child;

  const TemplateScreenWidget({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          iconSize: 30,
          icon: const Icon(
            Icons.close,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: title == null
            ? null
            : Text(
                title!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall,
              ),
      ),
      body: child,
    );
  }
}
