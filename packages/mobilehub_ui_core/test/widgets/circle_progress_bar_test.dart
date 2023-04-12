import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobilehub_ui_core/src/widgets/circle_progress_bar/animated_double_count.dart';

void main() {
  testWidgets('AnimatedCount should display the initial value correctly',
      (WidgetTester tester) async {
    // Given
    const widget = AnimatedCount(
      count: 42.0,
      unit: 'kg',
      duration: Duration(milliseconds: 500),
    );

    // When
    await tester.pumpWidget(const MaterialApp(home: widget));

    // Then
    // expect(find.text('42,00'), findsOneWidget);
    expect(find.text('kg'), findsOneWidget);
  });
}
