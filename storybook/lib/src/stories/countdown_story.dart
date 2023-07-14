import 'package:flutter/material.dart';
import 'package:mobilehub_ui_core/mobilehub_ui_core.dart';

import '../storybook/storybook.dart';

class CountdownStory extends Story {
  const CountdownStory({Key? key}) : super(key: key);

  @override
  List<WidgetMap> storyContent(BuildContext context) {
    return [
      WidgetMap(
        title: 'TimerCountDownWidget',
        builder: (context) => const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TimerCountDownWidget(
                time: 10 * 60,
              ),
            ],
          ),
        ),
      ),
      WidgetMap(
        title: 'TimeCountDown',
        builder: (context) => const Center(
          child: TimeCountDown(
            timeRemain: 10 * 60,
          ),
        ),
      ),
    ];
  }
}
