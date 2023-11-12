// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ObfuscationConfig _$ObfuscationConfigFromJson(Map<String, dynamic> json) {
  return _ObfuscationConfig.fromJson(json);
}

/// @nodoc
mixin _$ObfuscationConfig {
  @JsonKey(name: 'ignores_to_clone')
  List<IgnoreItem> get ignoresToClone => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ObfuscationConfigCopyWith<ObfuscationConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ObfuscationConfigCopyWith<$Res> {
  factory $ObfuscationConfigCopyWith(
          ObfuscationConfig value, $Res Function(ObfuscationConfig) then) =
      _$ObfuscationConfigCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'ignores_to_clone') List<IgnoreItem> ignoresToClone});
}

/// @nodoc
class _$ObfuscationConfigCopyWithImpl<$Res>
    implements $ObfuscationConfigCopyWith<$Res> {
  _$ObfuscationConfigCopyWithImpl(this._value, this._then);

  final ObfuscationConfig _value;
  // ignore: unused_field
  final $Res Function(ObfuscationConfig) _then;

  @override
  $Res call({
    Object? ignoresToClone = freezed,
  }) {
    return _then(_value.copyWith(
      ignoresToClone: ignoresToClone == freezed
          ? _value.ignoresToClone
          : ignoresToClone // ignore: cast_nullable_to_non_nullable
              as List<IgnoreItem>,
    ));
  }
}

/// @nodoc
abstract class _$$_ObfuscationConfigCopyWith<$Res>
    implements $ObfuscationConfigCopyWith<$Res> {
  factory _$$_ObfuscationConfigCopyWith(_$_ObfuscationConfig value,
          $Res Function(_$_ObfuscationConfig) then) =
      __$$_ObfuscationConfigCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'ignores_to_clone') List<IgnoreItem> ignoresToClone});
}

/// @nodoc
class __$$_ObfuscationConfigCopyWithImpl<$Res>
    extends _$ObfuscationConfigCopyWithImpl<$Res>
    implements _$$_ObfuscationConfigCopyWith<$Res> {
  __$$_ObfuscationConfigCopyWithImpl(
      _$_ObfuscationConfig _value, $Res Function(_$_ObfuscationConfig) _then)
      : super(_value, (v) => _then(v as _$_ObfuscationConfig));

  @override
  _$_ObfuscationConfig get _value => super._value as _$_ObfuscationConfig;

  @override
  $Res call({
    Object? ignoresToClone = freezed,
  }) {
    return _then(_$_ObfuscationConfig(
      ignoresToClone: ignoresToClone == freezed
          ? _value._ignoresToClone
          : ignoresToClone // ignore: cast_nullable_to_non_nullable
              as List<IgnoreItem>,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_ObfuscationConfig implements _ObfuscationConfig {
  const _$_ObfuscationConfig(
      {@JsonKey(name: 'ignores_to_clone')
      final List<IgnoreItem> ignoresToClone = const []})
      : _ignoresToClone = ignoresToClone;

  factory _$_ObfuscationConfig.fromJson(Map<String, dynamic> json) =>
      _$$_ObfuscationConfigFromJson(json);

  final List<IgnoreItem> _ignoresToClone;
  @override
  @JsonKey(name: 'ignores_to_clone')
  List<IgnoreItem> get ignoresToClone {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ignoresToClone);
  }

  @override
  String toString() {
    return 'ObfuscationConfig(ignoresToClone: $ignoresToClone)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ObfuscationConfig &&
            const DeepCollectionEquality()
                .equals(other._ignoresToClone, _ignoresToClone));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_ignoresToClone));

  @JsonKey(ignore: true)
  @override
  _$$_ObfuscationConfigCopyWith<_$_ObfuscationConfig> get copyWith =>
      __$$_ObfuscationConfigCopyWithImpl<_$_ObfuscationConfig>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ObfuscationConfigToJson(
      this,
    );
  }
}

abstract class _ObfuscationConfig implements ObfuscationConfig {
  const factory _ObfuscationConfig(
      {@JsonKey(name: 'ignores_to_clone')
      final List<IgnoreItem> ignoresToClone}) = _$_ObfuscationConfig;

  factory _ObfuscationConfig.fromJson(Map<String, dynamic> json) =
      _$_ObfuscationConfig.fromJson;

  @override
  @JsonKey(name: 'ignores_to_clone')
  List<IgnoreItem> get ignoresToClone;
  @override
  @JsonKey(ignore: true)
  _$$_ObfuscationConfigCopyWith<_$_ObfuscationConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

IgnoreItem _$IgnoreItemFromJson(Map<String, dynamic> json) {
  return _IgnoreItem.fromJson(json);
}

/// @nodoc
mixin _$IgnoreItem {
  @JsonKey(name: 'path')
  String get path => throw _privateConstructorUsedError;
  @JsonKey(name: 'path_to_import')
  String get pathToImport => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IgnoreItemCopyWith<IgnoreItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IgnoreItemCopyWith<$Res> {
  factory $IgnoreItemCopyWith(
          IgnoreItem value, $Res Function(IgnoreItem) then) =
      _$IgnoreItemCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'path') String path,
      @JsonKey(name: 'path_to_import') String pathToImport});
}

/// @nodoc
class _$IgnoreItemCopyWithImpl<$Res> implements $IgnoreItemCopyWith<$Res> {
  _$IgnoreItemCopyWithImpl(this._value, this._then);

  final IgnoreItem _value;
  // ignore: unused_field
  final $Res Function(IgnoreItem) _then;

  @override
  $Res call({
    Object? path = freezed,
    Object? pathToImport = freezed,
  }) {
    return _then(_value.copyWith(
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      pathToImport: pathToImport == freezed
          ? _value.pathToImport
          : pathToImport // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_IgnoreItemCopyWith<$Res>
    implements $IgnoreItemCopyWith<$Res> {
  factory _$$_IgnoreItemCopyWith(
          _$_IgnoreItem value, $Res Function(_$_IgnoreItem) then) =
      __$$_IgnoreItemCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'path') String path,
      @JsonKey(name: 'path_to_import') String pathToImport});
}

/// @nodoc
class __$$_IgnoreItemCopyWithImpl<$Res> extends _$IgnoreItemCopyWithImpl<$Res>
    implements _$$_IgnoreItemCopyWith<$Res> {
  __$$_IgnoreItemCopyWithImpl(
      _$_IgnoreItem _value, $Res Function(_$_IgnoreItem) _then)
      : super(_value, (v) => _then(v as _$_IgnoreItem));

  @override
  _$_IgnoreItem get _value => super._value as _$_IgnoreItem;

  @override
  $Res call({
    Object? path = freezed,
    Object? pathToImport = freezed,
  }) {
    return _then(_$_IgnoreItem(
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      pathToImport: pathToImport == freezed
          ? _value.pathToImport
          : pathToImport // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_IgnoreItem implements _IgnoreItem {
  const _$_IgnoreItem(
      {@JsonKey(name: 'path') required this.path,
      @JsonKey(name: 'path_to_import') required this.pathToImport});

  factory _$_IgnoreItem.fromJson(Map<String, dynamic> json) =>
      _$$_IgnoreItemFromJson(json);

  @override
  @JsonKey(name: 'path')
  final String path;
  @override
  @JsonKey(name: 'path_to_import')
  final String pathToImport;

  @override
  String toString() {
    return 'IgnoreItem(path: $path, pathToImport: $pathToImport)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_IgnoreItem &&
            const DeepCollectionEquality().equals(other.path, path) &&
            const DeepCollectionEquality()
                .equals(other.pathToImport, pathToImport));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(path),
      const DeepCollectionEquality().hash(pathToImport));

  @JsonKey(ignore: true)
  @override
  _$$_IgnoreItemCopyWith<_$_IgnoreItem> get copyWith =>
      __$$_IgnoreItemCopyWithImpl<_$_IgnoreItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_IgnoreItemToJson(
      this,
    );
  }
}

abstract class _IgnoreItem implements IgnoreItem {
  const factory _IgnoreItem(
      {@JsonKey(name: 'path') required final String path,
      @JsonKey(name: 'path_to_import')
      required final String pathToImport}) = _$_IgnoreItem;

  factory _IgnoreItem.fromJson(Map<String, dynamic> json) =
      _$_IgnoreItem.fromJson;

  @override
  @JsonKey(name: 'path')
  String get path;
  @override
  @JsonKey(name: 'path_to_import')
  String get pathToImport;
  @override
  @JsonKey(ignore: true)
  _$$_IgnoreItemCopyWith<_$_IgnoreItem> get copyWith =>
      throw _privateConstructorUsedError;
}
