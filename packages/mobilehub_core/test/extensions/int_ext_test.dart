import 'package:flutter_test/flutter_test.dart';
import 'package:mobilehub_core/mobilehub_core.dart';

void main() {
  

  group('should verify file format size', () {
    test('should display B', () {
      const sizeByte = 10111;
      expect(sizeByte.sizeText(), '9.87 KB');
    });

    test('should display KB', () {
      const sizeByte = 2899332;
      expect(sizeByte.sizeText(), '2.77 MB');
    });

    test('should display MB', () {
      const sizeByte = 12112899332;
      expect(sizeByte.sizeText(), '11.28 GB');
    });
  });
}
