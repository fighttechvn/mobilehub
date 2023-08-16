import 'package:flutter/material.dart';

import '../widgets/month_calendar.dart';

class MonthCalendarPickerDialog extends StatefulWidget {
  const MonthCalendarPickerDialog({
    super.key,
    required this.monthStr,
    this.value,
    this.minDate,
    this.maxDate,
    this.rangeStart,
    this.rangeEnd,
  });

  final String monthStr;
  final DateTime? value;
  final DateTime? minDate;
  final DateTime? maxDate;
  final DateTime? rangeStart;
  final DateTime? rangeEnd;

  @override
  State<MonthCalendarPickerDialog> createState() =>
      _MonthCalendarPickerDialogState();
}

class _MonthCalendarPickerDialogState extends State<MonthCalendarPickerDialog> {
  late DateTime datetime = widget.value ?? DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Material(
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(16),
            ),
            margin: EdgeInsets.symmetric(horizontal: 16),
            constraints: BoxConstraints(maxWidth: 400),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  MonthCalendar(
                    monthStr: widget.monthStr,
                    value: datetime,
                    minDate: widget.minDate,
                    maxDate: widget.maxDate,
                    rangeStart: widget.rangeStart,
                    rangeEnd: widget.rangeEnd,
                    onSelected: (date) {
                      setState(() {
                        datetime = date;
                      });
                    },
                    headerDecoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    headerMargin: EdgeInsets.only(bottom: 24),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, datetime);
                      },
                      child: Text('Xác nhận'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
