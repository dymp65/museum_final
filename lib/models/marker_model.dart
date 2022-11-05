class MarkerModel {
  MarkerModel({
    this.type,
    this.count,
    this.next,
    this.previous,
    this.features,
  });

  String? type;
  int? count;
  dynamic next;
  dynamic previous;
  List<FeatureModel>? features;

  factory MarkerModel.fromJson(Map<String, dynamic> json) => MarkerModel(
        type: json["type"],
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        features: List<FeatureModel>.from(
            json["features"].map((x) => FeatureModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "count": count,
        "next": next,
        "previous": previous,
        "features": List<dynamic>.from(features!.map((x) => x.toJson())),
      };
}

class FeatureModel {
  FeatureModel({
    this.id,
    this.type,
    this.geometry,
    this.properties,
  });

  int? id;
  String? type;
  GeometryModel? geometry;
  PropertiesModel? properties;

  factory FeatureModel.fromJson(Map<String, dynamic> json) => FeatureModel(
        id: json["id"],
        type: json["type"],
        geometry: GeometryModel.fromJson(json["geometry"]),
        properties: PropertiesModel.fromJson(json["properties"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "geometry": geometry?.toJson(),
        "properties": properties?.toJson(),
      };
}

class GeometryModel {
  GeometryModel({
    this.type,
    this.coordinates,
  });

  String? type;
  List<double>? coordinates;

  factory GeometryModel.fromJson(Map<String, dynamic> json) => GeometryModel(
        type: json["type"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates!.map((x) => x)),
      };
}

class PropertiesModel {
  PropertiesModel({
    this.title,
    this.article,
    this.image,
    this.floor,
  });

  String? title;
  String? article;
  String? image;
  int? floor;

  factory PropertiesModel.fromJson(Map<String, dynamic> json) =>
      PropertiesModel(
        title: json["title"],
        article: json["article"],
        image: json["image"],
        floor: json["floor"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "article": article,
        "image": image,
        "floor": floor,
      };
}
