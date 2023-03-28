import 'package:flutter/material.dart';

import 'features/mobilehub_ui_core/list_block_builder.dart';
import 'features/mobilehub_ui_core/sliver_nested_scrollview_example.dart';

extension AppCoordinator on BuildContext {
  void pop() => Navigator.of(this).pop();

  Future<T?> startListBlockBuilder<T>() {
    return Navigator.of(this).pushNamed(ListBlockBuilderExample.routeName);
  }

  Future<T?> startSliverNestedScrollView<T>() {
    return Navigator.of(this)
        .pushNamed(SliverNestedScrollViewExample.routeName);
  }
}

class Routes {
  static Map<String, WidgetBuilder> _getAll(RouteSettings settings) => {
        ListBlockBuilderExample.routeName: (context) {
          return const ListBlockBuilderExample();
        },
        SliverNestedScrollViewExample.routeName: (context) {
          return const SliverNestedScrollViewExample();
        },
      };

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final builder = _getAll(settings)[settings.name!];
    if ([
      'RouteList.account',
    ].contains(settings.name)) {
      return pageRouteBuilder(builder);
    }

    // default
    return MaterialPageRoute(
      builder: builder!,
      settings: settings,
      fullscreenDialog: false,
    );
  }

  static PageRouteBuilder<dynamic> pageRouteBuilder(WidgetBuilder? builder) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return builder!(context);
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final tween =
            Tween(begin: const Offset(0.0, 1.0), end: Offset.zero).chain(
          CurveTween(curve: Curves.easeIn),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
