import 'package:flutter/material.dart';

import '../core/dependency_injection/injector_container.dart';

abstract class RouteModule extends InjectorContainerGet {
  Map<String, WidgetBuilder> getAll(RouteSettings settings);
}

abstract class RouteModuleBuilder extends InjectorContainerGet {
  List<RouteModule> get routes;

  ///
  /// External route loader
  ///
  List<RouteModuleBuilder> get routerModules => <RouteModuleBuilder>[];

  ///
  /// Expose get all router by name
  ///
  Map<String, WidgetBuilder> getAll(RouteSettings settings) =>
      _getAll(settings);

  Map<String, WidgetBuilder> _getAll(RouteSettings settings) {
    final result = <String, WidgetBuilder>{};
    for (final e in routes) {
      result.addAll(e.getAll(settings));
    }
    for (final e in routerModules) {
      result.addAll(e._getAll(settings));
    }
    return result;
  }

  Route<dynamic> generateRoute(RouteSettings settings) {
    final routeName = settings.name;

    if (routeName == null) {
      throw Exception('please check route name: $routeName');
    }

    final builder = _getAll(settings)[routeName];

    if (builder == null) {
      assert(builder != null, 'please check route builder:');
      throw Exception('please check route builder: $builder');
    }

    if ([
      '/',
    ].contains(settings.name)) {
      return pageRouteBuilder(builder);
    }
    final isShowDialog = routeName.contains('dialog');
    return MaterialPageRoute(
      builder: builder,
      settings: settings,
      fullscreenDialog: isShowDialog,
    );
  }

  PageRouteBuilder pageRouteBuilder(WidgetBuilder builder) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return builder(context);
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

extension CoodinatorBuildStartScreen on BuildContext {
  Future<T?> start<T>({
    required Widget child,
    Widget Function(BuildContext)? builder,
  }) {
    return Navigator.of(this).push(
      MaterialPageRoute(
        builder: (context) {
          if (builder != null) {
            return builder(context);
          }
          return child;
        },
      ),
    );
  }
}
