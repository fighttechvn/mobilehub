import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../locale/datetime/vi.dart';
import '../utils/date_utils.dart';
import '../utils/iterable_ext.dart';

class WeekCalendar extends StatefulWidget {
  const WeekCalendar({
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
    this.footerTextStyle,
    this.headerTextStyle,
  }) : super(key: key);

  final String monthStr;
  final DateTime? value;
  final DateTime? minDate;
  final DateTime? maxDate;
  final DateTime? rangeStart;
  final DateTime? rangeEnd;
  final AvailableGestures availableGestures;
  final DateLocale dateLocale;
  final void Function(DateTime selected) onSelected;
  final TextStyle? headerTextStyle;
  final TextStyle? footerTextStyle;

  @override
  State<WeekCalendar> createState() => _WeekCalendarState();
}

class _WeekCalendarState extends State<WeekCalendar> {
  late DateTime datetime = widget.value ?? DateTime.now();
  late DateTime forcusedDate = datetime;

  @override
  void didUpdateWidget(covariant WeekCalendar oldWidget) {
    datetime = widget.value ?? DateTime.now();
    forcusedDate = datetime;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final textTheme = themeData.textTheme;
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 500,
      ),
      child: Column(
        children: [
          _buildHeader(textTheme),
          TableCalendar(
            startingDayOfWeek: StartingDayOfWeek.monday,
            rangeStartDay: widget.rangeStart,
            availableGestures: widget.availableGestures,
            rangeEndDay: widget.rangeEnd,
            firstDay: DateTime.utc(2000, 01, 01),
            lastDay: DateTime.utc(2099, 12, 31),
            focusedDay: forcusedDate,
            currentDay: datetime,
            availableCalendarFormats: {
              CalendarFormat.week: widget.monthStr,
            },
            onDaySelected: (selectedDay, _) {
              setState(() {
                datetime = selectedDay;
                forcusedDate = selectedDay;
              });
              widget.onSelected.call(selectedDay);
            },
            enabledDayPredicate: (day) {
              var check1 = true;
              var check2 = true;
              if (widget.minDate != null) {
                check1 = day.isAfter(widget.minDate!) ||
                    day.isSameDay(widget.minDate!);
              }

              if (widget.maxDate != null) {
                check2 = day.isBefore(widget.maxDate!) ||
                    day.isSameDay(widget.maxDate!);
              }
              return check1 && check2;
            },
            headerVisible: false,
            daysOfWeekVisible: false,
            calendarBuilders: CalendarBuilders(
              dowBuilder: (context, day) {
                return Center(
                  child: Text(
                    widget.dateLocale.daysShort[day.weekday - 1],
                    style: textTheme.titleSmall,
                  ),
                );
              },
              headerTitleBuilder: (context, day) {
                return Text(day.toString());
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
            calendarFormat: CalendarFormat.week,
          ),
          const SizedBox(height: 16),
          _buildFooter(textTheme)
        ],
      ),
    );
  }

  Widget _buildHeader(TextTheme textTheme) {
    return LayoutBuilder(builder: (context, constraints) {
      return SizedBox(
        height: 50,
        child: ListView(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.horizontal,
          children: [
            ...widget.dateLocale.monthsShort.mapIndex(
              (e, index) => ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 50,
                  minWidth: constraints.maxWidth / 6,
                ),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      forcusedDate = DateTime.now().copyWith(
                        month: index,
                      );
                    });
                  },
                  child: Center(
                    child: Text(
                      e,
                      style: (widget.headerTextStyle ?? textTheme.titleMedium)
                          ?.copyWith(
                        fontWeight: forcusedDate.month == index
                            ? FontWeight.bold
                            : null,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Row _buildFooter(TextTheme textTheme) {
    return Row(
      children: [
        ...widget.dateLocale.daysShort.map(
          (e) => Expanded(
            child: Center(
              child: Text(
                e,
                style: widget.footerTextStyle ??
                    textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
