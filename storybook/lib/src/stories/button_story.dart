import 'package:flutter/material.dart';

import '../storybook/storybook.dart';

class ButtonStory extends Story {
  const ButtonStory({Key? key}) : super(key: key);

  @override
  List<WidgetMap> storyContent(BuildContext context) {
    const spacingBox = SizedBox(height: 12.0);
    return [
      WidgetMap(
        title: 'Button',
        builder: (context) => const Column(
          children: [
            spacingBox,
            Row(
              children: [
                Text('Button'),
              ],
            ),
            spacingBox,
          ],
        ),
      )
    ];
  }
}
