import 'package:flutter_test/flutter_test.dart';
import 'package:mobilehub_core/mobilehub_core.dart';

void main() {
  group('EasyDebounce', () {
    test('debounce should execute callback after duration', () async {
      var callbackExecuted = false;

      // Debounce the callback with a duration of 100ms.
      EasyDebounce.debounce('test-tag', const Duration(milliseconds: 100), () {
        callbackExecuted = true;
      });

      // Wait for 50ms, the callback should not have executed yet.
      await Future.delayed(const Duration(milliseconds: 50));
      expect(callbackExecuted, isFalse);

      // Wait for another 100ms, the callback should have executed by now.
      await Future.delayed(const Duration(milliseconds: 100));
      expect(callbackExecuted, isTrue);
    });
  });

  test('debounce should cancel previous call with same tag', () async {
    var callbackExecuted = 0;

    // Debounce the callback with a duration of 100ms.
    EasyDebounce.debounce('test-tag', const Duration(milliseconds: 100), () {
      callbackExecuted++;
    });

    // Wait for 50ms, the callback should not have executed yet.
    await Future.delayed(const Duration(milliseconds: 50));
    expect(callbackExecuted, equals(0));

    // Call debounce again with the same tag before the 100ms duration is up.
    // This should cancel the previous debounce operation.
    EasyDebounce.debounce('test-tag', const Duration(milliseconds: 100), () {
      callbackExecuted++;
    });

    // Wait for another 100ms, the callback should have only executed once.
    await Future.delayed(const Duration(milliseconds: 100));
    expect(callbackExecuted, equals(1));
  });

  test('fire should execute callback immediately', () async {
    var callbackExecuted = false;

    // Debounce the callback with a duration of 100ms.
    EasyDebounce.debounce('test-tag', const Duration(milliseconds: 100), () {
      callbackExecuted = true;
    });

    // Fire the callback immediately.
    EasyDebounce.fire('test-tag');

    // Wait for 50ms, the callback should have executed by now.
    await Future.delayed(const Duration(milliseconds: 50));
    expect(callbackExecuted, isTrue);
  });

  test('cancel should cancel debounce operation', () async {
    var callbackExecuted = false;

    // Debounce the callback with a duration of 100ms.
    EasyDebounce.debounce('test-tag', const Duration(milliseconds: 100), () {
      callbackExecuted = true;
    });

    // Cancel the debounce operation before the duration is up.
    EasyDebounce.cancel('test-tag');

    // Wait for 100ms, the callback should not have executed yet.
    await Future.delayed(const Duration(milliseconds: 100));
    expect(callbackExecuted, isFalse);
  });
}
