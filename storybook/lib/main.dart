import 'package:flutter/material.dart';

import 'src/stories/button_story.dart';
import 'src/storybook/storybook.dart';

Future<void> main() async {
  runApp(
    Builder(
      builder: (BuildContext context) {
        return const MaterialApp(
          // theme: DefaultTheme().build(context),
          home: Storybook(
            [
              ButtonStory(),
            ],
          ),
        );
      },
    ),
  );
}
