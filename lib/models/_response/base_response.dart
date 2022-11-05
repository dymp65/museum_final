import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:museum/models/meta_model.dart';

part 'base_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
@CopyWith()
class BaseResponse<T> {
  MetaModel? meta;
  T? data;

  BaseResponse({
    this.meta,
    this.data,
  });

  factory BaseResponse.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$BaseResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$BaseResponseToJson(this, toJsonT);
}
