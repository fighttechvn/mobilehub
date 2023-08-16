import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../locale/datetime/vi.dart';
import '../utils/date_utils.dart';

class MonthCalendar extends StatelessWidget {
  const MonthCalendar({
    Key? key,
    required this.monthStr,
    required this.value,
    required this.onSelected,
    this.minDate,
    this.maxDate,
    this.rangeStart,
    this.rangeEnd,
    this.availableGestures = AvailableGestures.all,
    this.dateLocale = const VIDateLocale(),
    this.headerDecoration = const BoxDecoration(),
    this.headerMargin = const EdgeInsets.all(0.0),
    this.headerPadding = const EdgeInsets.symmetric(vertical: 8.0),
  }) : super(key: key);

  final String monthStr;
  final DateTime? value;
  final DateTime? minDate;
  final DateTime? maxDate;
  final DateTime? rangeStart;
  final DateTime? rangeEnd;
  final AvailableGestures availableGestures;
  final DateLocale dateLocale;
  final BoxDecoration headerDecoration;
  final EdgeInsets headerPadding;
  final EdgeInsets headerMargin;
  final void Function(DateTime selected) onSelected;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final textTheme = themeData.textTheme;
    return TableCalendar(
      startingDayOfWeek: StartingDayOfWeek.monday,
      rangeStartDay: rangeStart,
      availableGestures: availableGestures,
      rangeEndDay: rangeEnd,
      firstDay: DateTime.utc(2000, 01, 01),
      lastDay: DateTime.utc(2099, 12, 31),
      focusedDay: value ?? DateTime.now(),
      currentDay: value ?? DateTime.now(),
      availableCalendarFormats: {
        CalendarFormat.month: monthStr,
      },
      locale: Localizations.localeOf(context).languageCode,
      onDaySelected: (selectedDay, _) {
        onSelected.call(selectedDay);
      },
      enabledDayPredicate: (day) {
        var check1 = true;
        var check2 = true;
        if (minDate != null) {
          check1 = day.isAfter(minDate!) || day.isSameDay(minDate!);
        }

        if (maxDate != null) {
          check2 = day.isBefore(maxDate!) || day.isSameDay(maxDate!);
        }
        return check1 && check2;
      },
      headerStyle: HeaderStyle(
        titleCentered: true,
        formatButtonDecoration: BoxDecoration(
          color: themeData.primaryColor,
          borderRadius: BorderRadius.circular(22.0),
        ),
        formatButtonTextStyle: const TextStyle(color: Colors.white),
        formatButtonShowsNext: false,
        titleTextFormatter: (date, locale) => formatDate(
          date,
          ['$monthStr ', 'mm', ', ', 'yyyy'],
          locale: dateLocale,
        ),
        headerPadding: headerPadding,
        headerMargin: headerMargin,
        decoration: headerDecoration,
      ),
      calendarBuilders: CalendarBuilders(
        dowBuilder: (context, day) {
          return Center(
            child: Text(
              dateLocale.daysShort[day.weekday - 1],
              style: textTheme.titleSmall,
            ),
          );
        },
      ),
      calendarStyle: CalendarStyle(
        selectedDecoration: BoxDecoration(
          color: themeData.colorScheme.primary,
          shape: BoxShape.circle,
        ),
        todayDecoration: BoxDecoration(
          color: themeData.colorScheme.primary,
          shape: BoxShape.circle,
        ),
        rangeHighlightColor: themeData.colorScheme.secondary,
        rangeStartDecoration: BoxDecoration(
          color: themeData.colorScheme.primary,
          shape: BoxShape.circle,
        ),
        rangeEndDecoration: BoxDecoration(
          color: themeData.colorScheme.primary,
          shape: BoxShape.circle,
        ),
      ),
      calendarFormat: CalendarFormat.month,
    );
  }
}
