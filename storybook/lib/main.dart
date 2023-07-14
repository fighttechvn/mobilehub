import 'package:flutter/material.dart';

import 'src/stories/hide_bottom_nav_story.dart';
import 'src/stories/social_dashboard_story.dart';
import 'src/stories/stories.dart';
import 'src/storybook/storybook.dart';

Future<void> main() async {
  runApp(
    Builder(
      builder: (BuildContext context) {
        return const MaterialApp(
          home: Storybook(
            [
              ButtonStory(),
              HoverStory(),
              SocialDashboardStory(),
              HideBottomNavStory(),
              RenderBoxInforStory(),
            ],
          ),
        );
      },
    ),
  );
}
