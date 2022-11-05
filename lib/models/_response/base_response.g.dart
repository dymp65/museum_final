// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BaseResponseCWProxy<T> {
  BaseResponse<T> data(T? data);

  BaseResponse<T> meta(MetaModel? meta);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BaseResponse<T>(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BaseResponse<T>(...).copyWith(id: 12, name: "My name")
  /// ````
  BaseResponse<T> call({
    T? data,
    MetaModel? meta,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBaseResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBaseResponse.copyWith.fieldName(...)`
class _$BaseResponseCWProxyImpl<T> implements _$BaseResponseCWProxy<T> {
  final BaseResponse<T> _value;

  const _$BaseResponseCWProxyImpl(this._value);

  @override
  BaseResponse<T> data(T? data) => this(data: data);

  @override
  BaseResponse<T> meta(MetaModel? meta) => this(meta: meta);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BaseResponse<T>(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BaseResponse<T>(...).copyWith(id: 12, name: "My name")
  /// ````
  BaseResponse<T> call({
    Object? data = const $CopyWithPlaceholder(),
    Object? meta = const $CopyWithPlaceholder(),
  }) {
    return BaseResponse<T>(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as T?,
      meta: meta == const $CopyWithPlaceholder()
          ? _value.meta
          // ignore: cast_nullable_to_non_nullable
          : meta as MetaModel?,
    );
  }
}

extension $BaseResponseCopyWith<T> on BaseResponse<T> {
  /// Returns a callable class that can be used as follows: `instanceOfBaseResponse.copyWith(...)` or like so:`instanceOfBaseResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BaseResponseCWProxy<T> get copyWith => _$BaseResponseCWProxyImpl<T>(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse<T> _$BaseResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    BaseResponse<T>(
      meta: json['meta'] == null
          ? null
          : MetaModel.fromJson(json['meta'] as Map<String, dynamic>),
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
    );

Map<String, dynamic> _$BaseResponseToJson<T>(
  BaseResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'meta': instance.meta,
      'data': _$nullableGenericToJson(instance.data, toJsonT),
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);
