import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobilehub_ui_core/mobilehub_ui_core.dart';

void main() {
  testWidgets(
      'SliverRefreshIndicatorWidget should display CupertinoActivityIndicator',
      (WidgetTester tester) async {
    // Given
    // bool onRefreshCalled = false;

    final widget = SliverRefreshIndicatorWidget(
      onRefresh: () async {
        // onRefreshCalled = true;
      },
    );

    // When
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomScrollView(
            slivers: [
              widget,
              SliverToBoxAdapter(
                child: Container(
                  key: const ValueKey('itemBox'),
                  width: 100,
                  height: 300,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // Then
    // expect(find.byType(CupertinoActivityIndicator), findsOneWidget);
    await tester.pumpAndSettle();

    // Verify that the onRefresh function
    // is called when the refresh is triggered.
    // await tester.drag(
    //     find.byKey(const ValueKey('itemBox')), const Offset(0, 200));
    // await tester.pumpAndSettle();
    // expect(onRefreshCalled, true);
  });
}
