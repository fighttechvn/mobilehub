import 'package:example/src/helper.dart';
import 'package:flutter/material.dart';
import 'package:imagewidget/imagewidget.dart';
import 'package:mobilehub_ui_core/mobilehub_ui_core.dart';

const cover =
    'https://images.unsplash.com/photo-1679487660558-272899b0701a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80';
const avatar =
    'https://images.unsplash.com/photo-1679641050348-ce42fa064f2f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80';

class SliverNestedScrollViewExample extends StatefulWidget {
  static const String routeName = 'sliverlayout';

  const SliverNestedScrollViewExample({super.key});

  @override
  State<SliverNestedScrollViewExample> createState() =>
      _SliverNestedScrollViewExampleState();
}

class _SliverNestedScrollViewExampleState
    extends State<SliverNestedScrollViewExample> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SliverLayoutNestedScrollView(
        cover: cover,
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const ImageWidget(
                    avatar,
                    width: 100,
                    height: 100,
                    borderRadius: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'TITLE',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                  ...100
                      .toListIndexObject(
                        (p0) => Container(
                          width: double.infinity,
                          height: 70,
                          alignment: Alignment.center,
                          color: Colors.green,
                          margin: const EdgeInsets.all(12),
                          child: Text(p0.toString()),
                        ),
                      )
                      .toList()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
