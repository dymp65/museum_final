import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'theme_data_model.g.dart';

@CopyWith()
@JsonSerializable()
class ThemeDataModel {
  dynamic id;
  dynamic name;

  ThemeDataModel({this.id, this.name});

  factory ThemeDataModel.fromJson(Map<String, dynamic> json) {
    return _$ThemeDataModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ThemeDataModelToJson(this);
}
