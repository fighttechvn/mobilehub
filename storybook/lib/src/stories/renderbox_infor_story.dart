import 'package:flutter/material.dart';
import 'package:mobilehub_ui_core/mobilehub_ui_core.dart';

import '../storybook/storybook.dart';

class RenderBoxInforStory extends Story {
  const RenderBoxInforStory({Key? key}) : super(key: key);

  @override
  List<WidgetMap> storyContent(BuildContext context) {
    const spacingBox = SizedBox(height: 12.0);
    return [
      WidgetMap(
        title: 'RenderBox Informtion',
        builder: (context) => const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            spacingBox,
            Center(child: _RenderObjectExample()),
            spacingBox,
          ],
        ),
      ),
    ];
  }
}

class _RenderObjectExample extends StatefulWidget {
  const _RenderObjectExample();

  @override
  State<_RenderObjectExample> createState() => __RenderObjectExampleState();
}

class __RenderObjectExampleState extends State<_RenderObjectExample> {
  String label = 'Get infor';

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (ct) {
        return GestureDetector(
          onLongPress: () {},
          onTap: () {
            final renderObj = ct.getRenderObjectInfo;
            setState(() {
              label = '''
position: ${renderObj.position.toString()}
size: ${renderObj.size.toString()}
''';
            });
          },
          child: Container(
            width: 300,
            alignment: Alignment.center,
            height: 80,
            color: Colors.green,
            child: Text(
              label,
            ),
          ),
        );
      },
    );
  }
}
