import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ValueNotifierSaved {
  final String key;
  final SharedPreferences _sharedPreferences;

  ValueNotifierSaved(
    this.key,
    this._sharedPreferences,
  ) {
    final val = _sharedPreferences.getInt(key) ?? 0;
    _controller = ValueNotifier<int>(val);
    _controller.addListener(() {
      _save(_controller.value);
    });
  }

  late ValueNotifier<int> _controller;

  void _save(int val) {
    _controller.value = val;

    _sharedPreferences.setInt(key, val);
  }

  int get saved => _controller.value;
  ValueNotifier<int> get controller => _controller;
}
