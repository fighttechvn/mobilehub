import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobilehub_ui_core/mobilehub_ui_core.dart';

void main() {
  late Widget sut;

  setUp(() {
    sut = const CheckBoxWidget(data: 'a');
  });

  group('CheckBox Widget render', () {
    testWidgets('Should render checkbox widget success',
        (WidgetTester tester) async {
      // Given

      // When
      await tester.pumpWidget(sut);

      // Then
      expect(find.byType(Container), findsOneWidget);
      expect(find.byKey(const ValueKey('checkbox_widget_key')), findsOneWidget);
    });

    testWidgets('Should tap checkbox widget success',
        (WidgetTester tester) async {
      // Given
      await tester.pumpWidget(sut);

      // When
      await tester.tap(find.byKey(const ValueKey('checkbox_widget_key')));

      // Then
      expect(find.byType(Container), findsOneWidget);
    });

    testWidgets('Should checkbox selected when onTap',
        (WidgetTester tester) async {
      // Given
      await tester.pumpWidget(sut);

      // When
      await tester.tap(find.byKey(const ValueKey('checkbox_widget_key')));

      // Then
      expect(find.byKey(const ValueKey('checkbox_widget_key')), findsOneWidget);
    });

    testWidgets('Should update when change value from parent',
        (WidgetTester tester) async {
      // Given
      const activeColor = Colors.black;
      const inactiveColor = Colors.white;

      await tester.pumpWidget(
        const TestCheckbox(
          activeColor: activeColor,
          inactiveColor: inactiveColor,
        ),
      );

      await tester.pumpAndSettle();

      // When
      await tester.tap(find.byKey(const ValueKey('key_tap1')));

      await tester.pumpAndSettle();

      // Then
      expect(
        ((tester.widget(find
                        .byKey(const ValueKey('checkbox_widget_container_key')))
                    as Container)
                .decoration as BoxDecoration)
            .color,
        activeColor,
      );
    });
  });
}

class TestCheckbox extends StatefulWidget {
  const TestCheckbox({
    Key? key,
    required this.activeColor,
    required this.inactiveColor,
  }) : super(key: key);

  final Color activeColor;
  final Color inactiveColor;

  @override
  State<TestCheckbox> createState() => _TestCheckboxState();
}

class _TestCheckboxState extends State<TestCheckbox> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: const ValueKey('key_tap1'),
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
      },
      child: CheckBoxWidget(
        isSelected: _isSelected,
        activeColor: widget.activeColor,
        inactiveColor: widget.inactiveColor,
        data: 'a',
      ),
    );
  }
}
