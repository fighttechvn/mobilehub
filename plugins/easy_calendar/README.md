
A simple way of doing it is as follows:
* First of all, add [intl](https://pub.dev/packages/intl) package to your pubspec.yaml file
* Then make modifications to your `main()`:

```dart
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}
```