import 'package:flutter/material.dart';
import 'package:imagewidget/imagewidget.dart';

class SliverLayoutNestedScrollView extends StatefulWidget {
  final Widget body;
  final String? cover;
  final Widget? header;

  const SliverLayoutNestedScrollView({
    super.key,
    required this.body,
    this.header,
    this.cover,
  });

  @override
  State<SliverLayoutNestedScrollView> createState() =>
      _SliverLayoutNestedScrollViewState();
}

class _SliverLayoutNestedScrollViewState
    extends State<SliverLayoutNestedScrollView> {
  final mainScrollController = ScrollController();
  final bgScrollController = ScrollController();

  @override
  void initState() {
    mainScrollController.addListener(() {
      bgScrollController.jumpTo(mainScrollController.position.pixels);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomScrollView(
          controller: bgScrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  if (widget.cover?.isNotEmpty ?? false)
                    SizedBox(
                      height: MediaQuery.of(context).padding.top + 88.0,
                      child: Center(
                        child: ImageWidget(
                          widget.cover!,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                    ),
                  SizedBox(height: MediaQuery.of(context).size.height),
                ],
              ),
            ),
          ],
        ),
        SafeArea(
          bottom: false,
          child: NestedScrollView(
            controller: mainScrollController,
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            floatHeaderSlivers: false,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: Navigator.of(context).pop,
                              child: const Icon(
                                Icons.arrow_back_sharp,
                                color: Color(0xff333333),
                              ),
                            ),
                          ],
                        ),
                        if (widget.header != null) widget.header!,
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: widget.body,
          ),
        ),
      ],
    );
  }
}
