import 'package:yaml/yaml.dart';

extension YamlExtention on YamlMap {
  Map<String, dynamic> recursiveCast() {
    final map = <String, dynamic>{};
    for (final entry in entries) {
      if (entry.value is YamlList &&
          (entry.value as YamlList).value.first is YamlMap) {
        map[entry.key.toString()] = [
          ...(entry.value as YamlList).map(
            (e) {
              return (e as YamlMap).recursiveCast();
            },
          )
        ];
      } else if (entry.value is YamlMap) {
        map[entry.key.toString()] = (entry.value as YamlMap).recursiveCast();
      } else {
        map[entry.key.toString()] = entry.value;
      }
    }
    return map;
  }
}
