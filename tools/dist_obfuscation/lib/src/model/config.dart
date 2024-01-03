// ignore_for_file: invalid_annotation_target, strict_raw_type

import 'package:freezed_annotation/freezed_annotation.dart';

part 'config.freezed.dart';
part 'config.g.dart';

@freezed
class ObfuscationConfig with _$ObfuscationConfig {
  @JsonSerializable(explicitToJson: true)
  const factory ObfuscationConfig({
    @Default([])
    @JsonKey(name: 'ignores_to_clone')
    List<IgnoreItem> ignoresToClone,
  }) = _ObfuscationConfig;

  factory ObfuscationConfig.fromJson(Map<String, dynamic> json) =>
      _$ObfuscationConfigFromJson(json);
}

@freezed
class IgnoreItem with _$IgnoreItem {
  @JsonSerializable(explicitToJson: true)
  const factory IgnoreItem({
    @JsonKey(name: 'path') required String path,
    @JsonKey(name: 'path_to_import') required String pathToImport,
  }) = _IgnoreItem;

  factory IgnoreItem.fromJson(Map<String, dynamic> json) =>
      _$IgnoreItemFromJson(json);
}
