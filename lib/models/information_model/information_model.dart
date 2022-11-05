import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:museum/models/theme_data_model/theme_data_model.dart';

part 'information_model.g.dart';

@CopyWith()
@JsonSerializable()
class InformationModel {
  dynamic slug;
  dynamic theme;
  dynamic title;
  dynamic thumbnail;
  dynamic active;
  dynamic description;
  dynamic image;

  InformationModel(
      {this.slug,
      this.theme,
      this.title,
      this.thumbnail,
      this.active,
      this.description,
      this.image});

  factory InformationModel.fromJson(Map<String, dynamic> json) {
    return _$InformationModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$InformationModelToJson(this);
}
