import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../locale/datetime/vi.dart';
import '../utils/date_utils.dart';
import '../utils/iterable_ext.dart';

class WeekCalendar<T> extends StatefulWidget {
  const WeekCalendar({
    Key? key,
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
    this.todayTextStyle = const TextStyle(
      color: const Color(0xFFFAFAFA),
      fontSize: 16.0,
    ),
    this.defaultTextStyle = const TextStyle(),
    this.outsideTextStyle = const TextStyle(color: const Color(0xFFAEAEAE)),
    this.singleMarkerBuilder,
    this.eventLoader,
  }) : super(key: key);

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
  final TextStyle todayTextStyle;
  final TextStyle defaultTextStyle;
  final TextStyle outsideTextStyle;
  final SingleMarkerBuilder<T>? singleMarkerBuilder;

  /// Function that assigns a list of events to a specified day.
  final List<T> Function(DateTime day)? eventLoader;

  @override
  State<WeekCalendar<T>> createState() => _WeekCalendarState<T>();
}

class _WeekCalendarState<T> extends State<WeekCalendar<T>> {
  late DateTime datetime = widget.value ?? DateTime.now();
  late DateTime forcusedDate = datetime;

  @override
  void didUpdateWidget(covariant WeekCalendar<T> oldWidget) {
    datetime = widget.value ?? DateTime.now();
    forcusedDate = datetime;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final textTheme = themeData.textTheme;
    return ConstrainedBox(
      constraints: BoxConstraints(),
      child: Column(
        children: [
          _buildHeader(textTheme),
          TableCalendar<T>(
            startingDayOfWeek: StartingDayOfWeek.monday,
            rangeStartDay: widget.rangeStart,
            availableGestures: widget.availableGestures,
            rangeEndDay: widget.rangeEnd,
            firstDay: DateTime.utc(2000, 01, 01),
            lastDay: DateTime.utc(2099, 12, 31),
            focusedDay: forcusedDate,
            currentDay: datetime,
            availableCalendarFormats: {
              CalendarFormat.week: 'week',
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
              singleMarkerBuilder: widget.singleMarkerBuilder,
            ),
            eventLoader: widget.eventLoader,
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
              todayTextStyle: widget.todayTextStyle,
              defaultTextStyle: widget.defaultTextStyle,
              weekendTextStyle: widget.defaultTextStyle,
              outsideTextStyle: widget.outsideTextStyle,
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
                child: MonthTitleWidget(
                  onChange: (d) {
                    setState(() {
                      forcusedDate = d;
                    });
                  },
                  textStyle: widget.headerTextStyle,
                  month: index + 1,
                  title: e,
                  forcusedDate: forcusedDate,
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

class MonthTitleWidget extends StatefulWidget {
  const MonthTitleWidget({
    super.key,
    required this.title,
    required this.month,
    required this.forcusedDate,
    required this.onChange,
    this.textStyle,
  });

  final String title;
  final int month;
  final DateTime forcusedDate;
  final void Function(DateTime forcusedDate) onChange;
  final TextStyle? textStyle;

  @override
  State<MonthTitleWidget> createState() => _MonthTitleWidgetState();
}

class _MonthTitleWidgetState extends State<MonthTitleWidget> {
  void focus() {
    if (widget.forcusedDate.month == widget.month)
      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) {
          Scrollable.ensureVisible(
            context,
            duration: const Duration(milliseconds: 150),
            alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtEnd,
          );
        },
      );
  }

  @override
  void initState() {
    focus();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MonthTitleWidget oldWidget) {
    focus();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {
        widget.onChange(DateTime.now().copyWith(
          month: widget.month,
        ));
      },
      child: Center(
        child: Text(
          widget.title,
          style: (widget.textStyle ?? textTheme.titleMedium)?.copyWith(
              fontWeight: widget.forcusedDate.month == widget.month
                  ? FontWeight.bold
                  : null,
              color: widget.forcusedDate.month == widget.month
                  ? null
                  : (widget.textStyle ?? textTheme.titleMedium)
                      ?.color
                      ?.withOpacity(0.5)),
        ),
      ),
    );
  }
}
