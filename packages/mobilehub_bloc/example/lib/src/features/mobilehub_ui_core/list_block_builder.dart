import 'package:flutter/material.dart';

class ListBlockBuilderExample extends StatefulWidget {
  static const String routeName = 'listblock-builder';

  const ListBlockBuilderExample({super.key});

  @override
  State<ListBlockBuilderExample> createState() =>
      _ListBlockBuilderExampleState();
}

class _ListBlockBuilderExampleState extends State<ListBlockBuilderExample> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('body'),
      ),
    );
  }
}
