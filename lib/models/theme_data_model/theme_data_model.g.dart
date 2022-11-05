// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_data_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ThemeDataModelCWProxy {
  ThemeDataModel id(dynamic id);

  ThemeDataModel name(dynamic name);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ThemeDataModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ThemeDataModel(...).copyWith(id: 12, name: "My name")
  /// ````
  ThemeDataModel call({
    dynamic? id,
    dynamic? name,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfThemeDataModel.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfThemeDataModel.copyWith.fieldName(...)`
class _$ThemeDataModelCWProxyImpl implements _$ThemeDataModelCWProxy {
  final ThemeDataModel _value;

  const _$ThemeDataModelCWProxyImpl(this._value);

  @override
  ThemeDataModel id(dynamic id) => this(id: id);

  @override
  ThemeDataModel name(dynamic name) => this(name: name);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ThemeDataModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ThemeDataModel(...).copyWith(id: 12, name: "My name")
  /// ````
  ThemeDataModel call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
  }) {
    return ThemeDataModel(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as dynamic,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as dynamic,
    );
  }
}

extension $ThemeDataModelCopyWith on ThemeDataModel {
  /// Returns a callable class that can be used as follows: `instanceOfThemeDataModel.copyWith(...)` or like so:`instanceOfThemeDataModel.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ThemeDataModelCWProxy get copyWith => _$ThemeDataModelCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThemeDataModel _$ThemeDataModelFromJson(Map<String, dynamic> json) =>
    ThemeDataModel(
      id: json['id'],
      name: json['name'],
    );

Map<String, dynamic> _$ThemeDataModelToJson(ThemeDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
