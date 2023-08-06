import 'package:intl/intl.dart';

extension DoubleExt on double {
  String toStringAsMaxFixed(int fractionDigits) {
    final formatter = NumberFormat()
      ..minimumFractionDigits = 0
      ..maximumFractionDigits = fractionDigits;
    return formatter.format(this);
  }
}
