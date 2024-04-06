import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DetailVideoWidget extends StatefulWidget {
  final String heroTag;
  final Widget player;
  final double aspectRatio;

  final Widget Function(void Function()? callbackFullScreen)?
      buildControllerWidget;

  const DetailVideoWidget({
    super.key,
    required this.heroTag,
    required this.player,
    required this.aspectRatio,
    this.buildControllerWidget,
  });

  @override
  State<DetailVideoWidget> createState() => DetailVideoWidgetState();
}

class DetailVideoWidgetState extends State<DetailVideoWidget> {
  bool useSensor = false;
  final slidePagekey = GlobalKey<ExtendedImageSlidePageState>();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return Stack(
          children: [
            Material(
              color: Colors.black,
              child: Stack(
                children: [
                  Center(
                    child: Stack(
                      children: [
                        orientation == Orientation.portrait
                            ? ExtendedImageSlidePage(
                                key: slidePagekey,
                                slideAxis: SlideAxis.both,
                                slideType: SlideType.onlyImage,
                                child: ExtendedImageSlidePageHandler(
                                  child: AspectRatio(
                                    aspectRatio: widget.aspectRatio,
                                    child: Stack(
                                      children: [
                                        widget.player,
                                        buildControlWidget(orientation),
                                      ],
                                    ),
                                  ),

                                  ///make hero better when slide out
                                  heroBuilderForSlidingPage: (Widget result) {
                                    return Hero(
                                      tag: widget.heroTag,
                                      child: result,
                                      flightShuttleBuilder: (
                                        BuildContext flightContext,
                                        Animation<double> animation,
                                        HeroFlightDirection flightDirection,
                                        BuildContext fromHeroContext,
                                        BuildContext toHeroContext,
                                      ) {
                                        final hero = (flightDirection ==
                                                HeroFlightDirection.pop
                                            ? fromHeroContext.widget
                                            : toHeroContext.widget) as Hero;

                                        return Container(
                                          color: Colors.white,
                                          child: hero.child,
                                        );
                                      },
                                    );
                                  },
                                ),
                              )
                            : Stack(
                                children: [
                                  Center(
                                    child: AspectRatio(
                                      aspectRatio: widget.aspectRatio,
                                      child: widget.player,
                                    ),
                                  ),
                                  buildControlWidget(orientation),
                                ],
                              ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: orientation == Orientation.landscape
                        ? 24
                        : MediaQuery.of(context).padding.top + 24,
                    left: 24,
                    child: GestureDetector(
                      onTap: () {
                        if (orientation == Orientation.landscape) {
                          SystemChrome.setPreferredOrientations([
                            DeviceOrientation.portraitUp,
                            DeviceOrientation.portraitDown,
                          ]);
                        } else {
                          slidePagekey.currentState?.popPage();
                          Navigator.pop(context);
                        }
                      },
                      child: const Icon(
                        Icons.arrow_back_sharp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // if (orientation == Orientation.portrait)
            //   const Positioned(
            //     left: 0,
            //     bottom: 0,
            //     child: ImageWidget(ImageConstants.elinkGreyLeft),
            //   ),
          ],
        );
      },
    );
  }

  Widget buildControlWidget(Orientation orientation) {
    if (widget.buildControllerWidget == null) {
      return const SizedBox();
    }
    return widget.buildControllerWidget!(
      () {
        if (orientation == Orientation.portrait) {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.landscapeRight,
            DeviceOrientation.landscapeLeft,
          ]);
        } else {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitDown,
            DeviceOrientation.portraitUp,
          ]);
        }
      },
    );
  }
}
