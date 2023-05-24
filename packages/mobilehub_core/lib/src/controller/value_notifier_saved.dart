import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ValueNotifierSaved<T> {
  final String key;
  final SharedPreferences _sharedPreferences;

  ValueNotifierSaved(
    this.key,
    this._sharedPreferences,
  ) {
    final tType = T.toString();
    if (tType == 'String?' || tType == 'String') {
      final val = _sharedPreferences.getString(key);
      _controller = ValueNotifier<T>(val as T);
    } else if (tType == 'int?' || tType == 'int') {
      final val = _sharedPreferences.getInt(key);
      _controller = ValueNotifier<T>(val as T);
    } else if (tType == 'double?' || tType == 'double') {
      final val = _sharedPreferences.getDouble(key);

      _controller = ValueNotifier<T>(val as T);
    } else if (tType == 'bool?' || tType == 'bool') {
      final val = _sharedPreferences.getBool(key);
      _controller = ValueNotifier<T>(val as T);
    }

    _controller.addListener(() {
      _save(_controller.value);
    });
  }

  late ValueNotifier<T> _controller;

  void _save(T val) {
    _controller.value = val;

    final tType = T.toString();
    if (tType == 'String?' || tType == 'String') {
      _sharedPreferences.setString(key, val as String);
    } else if (tType == 'int?' || tType == 'int') {
      _sharedPreferences.setInt(key, val as int);
    } else if (tType == 'double?' || tType == 'double') {
      _sharedPreferences.setDouble(key, val as double);
    } else if (tType == 'bool?' || tType == 'bool') {
      _sharedPreferences.setBool(key, val as bool);
    }
  }

  T get saved => _controller.value;
  ValueNotifier<T> get controller => _controller;
}
