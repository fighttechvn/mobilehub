import 'package:flutter/material.dart';
import 'package:imagewidget/imagewidget.dart';

class SliverLayoutNestedScrollView extends StatefulWidget {
  final Widget Function(ScrollController) bodyBuilder;
  final String? cover;
  final Widget? header;

  const SliverLayoutNestedScrollView({
    super.key,
    required this.bodyBuilder,
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
  final ValueNotifier<double> _posined = ValueNotifier(0.0);
  @override
  void initState() {
    mainScrollController.addListener(() {
      _posined.value = mainScrollController.position.pixels;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ValueListenableBuilder<double>(
            valueListenable: _posined,
            builder: (_, pos, __) {
              return Positioned(
                top: -pos,
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
                  ],
                ),
              );
            }),
        SafeArea(
          bottom: false,
          child: NestedScrollView(
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
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Row(
                            children: [
                              GestureDetector(
                                key: const ValueKey('btnSliverlayoutBack'),
                                onTap: Navigator.of(context).pop,
                                child: const Icon(
                                  Icons.arrow_back_sharp,
                                  color: Color(0xff333333),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (widget.header != null) widget.header!,
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: widget.bodyBuilder(mainScrollController),
          ),
        ),
      ],
    );
  }
}
