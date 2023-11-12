// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ObfuscationConfig _$$_ObfuscationConfigFromJson(Map<String, dynamic> json) =>
    _$_ObfuscationConfig(
      ignoresToClone: (json['ignores_to_clone'] as List<dynamic>?)
              ?.map((e) => IgnoreItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_ObfuscationConfigToJson(
        _$_ObfuscationConfig instance) =>
    <String, dynamic>{
      'ignores_to_clone':
          instance.ignoresToClone.map((e) => e.toJson()).toList(),
    };

_$_IgnoreItem _$$_IgnoreItemFromJson(Map<String, dynamic> json) =>
    _$_IgnoreItem(
      path: json['path'] as String,
      pathToImport: json['path_to_import'] as String,
    );

Map<String, dynamic> _$$_IgnoreItemToJson(_$_IgnoreItem instance) =>
    <String, dynamic>{
      'path': instance.path,
      'path_to_import': instance.pathToImport,
    };
