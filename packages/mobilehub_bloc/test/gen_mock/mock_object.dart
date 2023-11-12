import 'package:mockito/annotations.dart';

@GenerateMocks([
  ServiceGetList,
])
void main() {}

abstract class ServiceGetList {
  Future<List<String>> getListingString();
  Future<List<String>> getListingStringParam1(int param);
}
