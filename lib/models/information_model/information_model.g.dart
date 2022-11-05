// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'information_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$InformationModelCWProxy {
  InformationModel active(dynamic active);

  InformationModel description(dynamic description);

  InformationModel image(dynamic image);

  InformationModel slug(dynamic slug);

  InformationModel theme(dynamic theme);

  InformationModel thumbnail(dynamic thumbnail);

  InformationModel title(dynamic title);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `InformationModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// InformationModel(...).copyWith(id: 12, name: "My name")
  /// ````
  InformationModel call({
    dynamic? active,
    dynamic? description,
    dynamic? image,
    dynamic? slug,
    dynamic? theme,
    dynamic? thumbnail,
    dynamic? title,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfInformationModel.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfInformationModel.copyWith.fieldName(...)`
class _$InformationModelCWProxyImpl implements _$InformationModelCWProxy {
  final InformationModel _value;

  const _$InformationModelCWProxyImpl(this._value);

  @override
  InformationModel active(dynamic active) => this(active: active);

  @override
  InformationModel description(dynamic description) =>
      this(description: description);

  @override
  InformationModel image(dynamic image) => this(image: image);

  @override
  InformationModel slug(dynamic slug) => this(slug: slug);

  @override
  InformationModel theme(dynamic theme) => this(theme: theme);

  @override
  InformationModel thumbnail(dynamic thumbnail) => this(thumbnail: thumbnail);

  @override
  InformationModel title(dynamic title) => this(title: title);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `InformationModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// InformationModel(...).copyWith(id: 12, name: "My name")
  /// ````
  InformationModel call({
    Object? active = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? image = const $CopyWithPlaceholder(),
    Object? slug = const $CopyWithPlaceholder(),
    Object? theme = const $CopyWithPlaceholder(),
    Object? thumbnail = const $CopyWithPlaceholder(),
    Object? title = const $CopyWithPlaceholder(),
  }) {
    return InformationModel(
      active: active == const $CopyWithPlaceholder() || active == null
          ? _value.active
          // ignore: cast_nullable_to_non_nullable
          : active as dynamic,
      description:
          description == const $CopyWithPlaceholder() || description == null
              ? _value.description
              // ignore: cast_nullable_to_non_nullable
              : description as dynamic,
      image: image == const $CopyWithPlaceholder() || image == null
          ? _value.image
          // ignore: cast_nullable_to_non_nullable
          : image as dynamic,
      slug: slug == const $CopyWithPlaceholder() || slug == null
          ? _value.slug
          // ignore: cast_nullable_to_non_nullable
          : slug as dynamic,
      theme: theme == const $CopyWithPlaceholder() || theme == null
          ? _value.theme
          // ignore: cast_nullable_to_non_nullable
          : theme as dynamic,
      thumbnail: thumbnail == const $CopyWithPlaceholder() || thumbnail == null
          ? _value.thumbnail
          // ignore: cast_nullable_to_non_nullable
          : thumbnail as dynamic,
      title: title == const $CopyWithPlaceholder() || title == null
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as dynamic,
    );
  }
}

extension $InformationModelCopyWith on InformationModel {
  /// Returns a callable class that can be used as follows: `instanceOfInformationModel.copyWith(...)` or like so:`instanceOfInformationModel.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$InformationModelCWProxy get copyWith => _$InformationModelCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InformationModel _$InformationModelFromJson(Map<String, dynamic> json) =>
    InformationModel(
      slug: json['slug'],
      theme: json['theme'],
      title: json['title'],
      thumbnail: json['thumbnail'],
      active: json['active'],
      description: json['description'],
      image: json['image'],
    );

Map<String, dynamic> _$InformationModelToJson(InformationModel instance) =>
    <String, dynamic>{
      'slug': instance.slug,
      'theme': instance.theme,
      'title': instance.title,
      'thumbnail': instance.thumbnail,
      'active': instance.active,
      'description': instance.description,
      'image': instance.image,
    };
