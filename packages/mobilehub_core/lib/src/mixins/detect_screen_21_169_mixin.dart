import 'package:flutter/material.dart';

mixin DetectScreen21169Mixin<T extends StatefulWidget> on State<T> {
  bool get is169 {
    final size = MediaQuery.of(context).size;
    final isRatio169 = (size.height / size.width) < (2 / 1);

    return isRatio169;
  }

  double detect169({required double ratio21, required double ratio169}) =>
      is169 ? ratio169 : ratio21;
}
