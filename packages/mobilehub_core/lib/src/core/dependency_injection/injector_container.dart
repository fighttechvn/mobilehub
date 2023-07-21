import 'package:get_it/get_it.dart';

GetIt injector = GetIt.instance;

abstract class InjectorContainerGet {
  T get<T extends Object>() => injector.get<T>();

  GetIt get injector => GetIt.instance;
}
