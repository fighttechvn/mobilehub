import 'package:flutter/material.dart';
import 'package:imagewidget/imagewidget.dart';
import 'package:mobilehub_core/mobilehub_core.dart';

import 'hightlight_action_entity.dart';
import 'widgets/hightlight_button_widget.dart';

class HightlightActionSliderWidget extends StatefulWidget {
  const HightlightActionSliderWidget({
    super.key,
    required this.items,
    required this.onTap,
    this.widgetItem,
    required this.styleTitle,
    required this.styletitleLog,
  });

  final List<HightLightAction> items;
  final void Function(HightLightAction item) onTap;
  final double? widgetItem;
  final TextStyle styleTitle;
  final TextStyle styletitleLog;

  @override
  State<HightlightActionSliderWidget> createState() =>
      _HightlightActionSliderWidgetState();
}

class _HightlightActionSliderWidgetState
    extends State<HightlightActionSliderWidget> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ...widget.items
            .map(
              (e) => InkWell(
                onTap: () {
                  widget.onTap(e);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: InsightsMenuWidget(
                    width: widget.widgetItem,
                    minHeight: context.is169 ? 150 : 140,
                    backgroundColor: e.backgroundColor?.toColor ?? Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          e.title ?? '',
                          style: widget.styleTitle.copyWith(height: 12 / 10),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          e.subTitle ?? '',
                          style: widget.styletitleLog.copyWith(height: 14 / 12),
                        ),
                        const SizedBox(height: 16),
                        if (e.image?.isNotEmpty ?? false)
                          Row(
                            children: [
                              const SizedBox(width: 16),
                              Flexible(
                                child: ImageWidget(
                                  e.image!,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ],
                          )
                      ],
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ],
    );
  }
}
