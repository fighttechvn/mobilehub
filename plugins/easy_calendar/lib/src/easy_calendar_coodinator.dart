import 'package:flutter/material.dart';

import 'picker_dialogs/month_calendar_picker_dialog.dart';

extension EasyCalendarCoodinator on BuildContext {
  Future<DateTime?> showMonthCalendarPicker({
    String monthStr = 'Tháng',
    DateTime? initial,
    DateTime? minDate,
    DateTime? maxDate,
    DateTime? rangeStart,
    DateTime? rangeEnd,
  }) async {
    final result = await showDialog(
      context: this,
      builder: (context) {
        return MonthCalendarPickerDialog(
          monthStr: monthStr,
          value: initial,
          minDate: minDate,
          maxDate: maxDate,
          rangeStart: rangeStart,
          rangeEnd: rangeEnd,
        );
      },
    );

    if (result is DateTime) {
      return result;
    }
    return null;
  }
}
