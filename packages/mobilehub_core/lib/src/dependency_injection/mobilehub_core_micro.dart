import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

// short const => @microPackageInit
@InjectableInit.microPackage()
void initMobileHubCoreMicroPackage() {} // will not be called

GetIt injector = GetIt.instance;

abstract class InjectorGet {
  T get<T extends Object>() => injector.get<T>();
}

abstract class RouteModule extends InjectorGet {
  GetIt get injector => GetIt.instance;

  Map<String, WidgetBuilder> getAll(RouteSettings settings);
}

abstract class RouteModuleBuilder extends InjectorGet{
  List<RouteModule> get routes;

  Map<String, WidgetBuilder> getAll(RouteSettings settings) {
    final result = <String, WidgetBuilder>{};
    for (final e in routes) {
      result.addAll(e.getAll(settings));
    }
    return result;
  }
}
