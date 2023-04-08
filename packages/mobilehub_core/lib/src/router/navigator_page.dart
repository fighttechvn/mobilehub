import 'package:flutter/material.dart';

import 'route_module.dart';

class NavigatorPage extends StatelessWidget {
  const NavigatorPage({
    super.key,
    required this.initialRoute,
    this.navigationKey,
    this.scrollController,
    required this.routes,
  });

  final String initialRoute;
  final GlobalKey<NavigatorState>? navigationKey;
  final ScrollController? scrollController;
  final RouteModuleBuilder routes;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigationKey,
      initialRoute: initialRoute,
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == '/') {
          return routes.generateRoute(
            RouteSettings(
              name: initialRoute,
              arguments: settings.arguments,
            ),
          );
        }
        return routes.generateRoute(settings);
      },
    );
  }
}
