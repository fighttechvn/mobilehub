import 'package:flutter/material.dart';
import 'package:mobilehub_ui_core/mobilehub_ui_core.dart';

import '../../storybook/storybook.dart';

class HoverStory extends Story {
  const HoverStory({Key? key}) : super(key: key);

  @override
  List<WidgetMap> storyContent(BuildContext context) {
    return [
      WidgetMap(
        title: 'XHover',
        builder: (context) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Expanded(child: SizedBox()),
                  XHover(
                    onTap: () {},
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Theme.of(context).primaryColor),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    hoverChild: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.zoom_in_map),
                        SizedBox(width: 13.0),
                        Text('Zooo'),
                      ],
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                ],
              ),
              const SizedBox(height: 12.0),
              Row(
                children: [
                  const Expanded(child: SizedBox()),
                  XHover(
                    alwaysShowHoverItem: true,
                    onTap: () {},
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Theme.of(context).primaryColor),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    hoverChild: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.zoom_in_map),
                        SizedBox(width: 13.0),
                        Text('Zooo'),
                      ],
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                ],
              ),
            ],
          ),
        ),
      )
    ];
  }
}

@immutable
class FoodDemo {
  final String? id;
  final String name;

  const FoodDemo({
    required this.name,
    this.id,
  });
}
