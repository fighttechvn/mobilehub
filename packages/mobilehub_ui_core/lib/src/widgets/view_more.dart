import 'package:flutter/material.dart';
import 'package:mobilehub_core/mobilehub_core.dart';

import '../../mobilehub_ui_core.dart';

class ViewMoreWidget extends StatefulWidget {
  final Widget child;
  final bool expand;
  final String viewMore;
  final String seeLess;
  final double minHeight;

  const ViewMoreWidget({
    Key? key,
    required this.child,
    this.expand = false,
    required this.viewMore,
    required this.seeLess,
    this.minHeight = 200,
  }) : super(key: key);

  @override
  State<ViewMoreWidget> createState() => _ViewMoreWidgetState();
}

class _ViewMoreWidgetState extends State<ViewMoreWidget> {
  bool expand = false;
  Size? childSize;

  @override
  void initState() {
    expand = widget.expand;
    super.initState();
  }

  @override
  void didUpdateWidget(ViewMoreWidget oldWidget) {
    if (oldWidget.expand != widget.expand) {
      expand = widget.expand;
    }
    super.didUpdateWidget(oldWidget);
  }

  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  double get btnHeight => 58;

  @override
  Widget build(BuildContext context) {
    _themeData = context.theme;

    if (childSize == null) {
      return _buildMeasureSize();
    }
    if (widget.minHeight >= childSize!.height) {
      return MeasureSize(
        onChange: (size) {
          if (childSize == null ||
              size.height > childSize!.height ||
              size.width > childSize!.width) {
            setState(() {
              childSize = size;
            });
          }
        },
        child: widget.child,
      );
    }
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        AnimatedContainer(
          height: expand ? childSize!.height + 38 : widget.minHeight,
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: MeasureSize(
              onChange: (size) {
                if (childSize == null ||
                    size.height > childSize!.height ||
                    size.width > childSize!.width) {
                  setState(() {
                    childSize = size;
                  });
                }
              },
              child: widget.child,
            ),
          ),
        ),
        _buildBtn(),
      ],
    );
  }

  Widget _buildMeasureSize() {
    return SizedBox(
      height: 1,
      child: SingleChildScrollView(
        child: MeasureSize(
          onChange: (size) {
            if (childSize == null ||
                size.height > childSize!.height ||
                size.width > childSize!.width) {
              setState(() {
                childSize = size;
              });
            }
          },
          child: widget.child,
        ),
      ),
    );
  }

  Widget _buildBtn() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0, 0.7, 1],
          colors: expand
              ? [Colors.transparent, Colors.transparent, Colors.transparent]
              : [Colors.white10, Colors.white, Colors.white],
        ),
      ),
      height: expand ? null : btnHeight,
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        onTap: () {
          setState(() {
            expand = !expand;
          });
        },
        child: Row(
          children: [
            const Expanded(child: Divider(thickness: 0.5, height: 1)),
            const SizedBox(width: 8),
            Text(
              expand ? widget.seeLess : widget.viewMore,
              style: textTheme.titleMedium?.copyWith(
                color: context.theme.colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            Icon(
              expand
                  ? Icons.keyboard_arrow_up_outlined
                  : Icons.keyboard_arrow_down_outlined,
              size: 18,
              color: context.theme.colorScheme.primary,
            ),
            const SizedBox(width: 4),
            const Expanded(child: Divider(thickness: 0.5, height: 1)),
          ],
        ),
      ),
    );
  }
}
