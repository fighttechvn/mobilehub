import 'package:date_format/date_format.dart';

class ENDateLocale implements DateLocale {
  const ENDateLocale();
  @override
  List<String> get monthsShort => [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
      ];

  @override
  List<String> get monthsLong => [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December'
      ];

  @override
  List<String> get daysShort =>
      ['Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat', 'Sun'];

  @override
  List<String> get daysLong => [
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday',
        'Sunday'
      ];

  @override
  String get am => 'AM';

  @override
  String get pm => 'PM';
}
