import 'package:flutter/material.dart';
import 'package:mobilehub_ui_core/mobilehub_ui_core.dart';

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
      ),
      WidgetMap(
        title: 'ElevatedButtonShadow',
        builder: (context) => Center(
          child: Column(
            children: [
              spacingBox,
              const ElevatedButtonShadow(label: 'label'),
              spacingBox,
              ElevatedButtonShadow(
                label: 'label',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    ];
  }
}
