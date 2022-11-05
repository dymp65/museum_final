class GeojsonModel {
  GeojsonModel({
    this.type,
    this.name,
    this.crs,
    this.features,
  });

  String? type;
  String? name;
  Crs? crs;
  List<Feature>? features;

  factory GeojsonModel.fromJson(Map<String, dynamic> json) => GeojsonModel(
    type: json["type"],
    name: json["name"],
    crs: Crs.fromJson(json["crs"]),
    features: List<Feature>.from(json["features"].map((x) => Feature.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "name": name,
    "crs": crs?.toJson(),
    "features": List<dynamic>.from(features!.map((x) => x.toJson())),
  };
}

class Crs {
  Crs({
    this.type,
    this.properties,
  });

  String? type;
  CrsProperties? properties;

  factory Crs.fromJson(Map<String, dynamic> json) => Crs(
    type: json["type"],
    properties: CrsProperties.fromJson(json["properties"]),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "properties": properties?.toJson(),
  };
}

class CrsProperties {
  CrsProperties({
    this.name,
  });

  String? name;

  factory CrsProperties.fromJson(Map<String, dynamic> json) => CrsProperties(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}

class Feature {
  Feature({
    this.type,
    this.properties,
    this.geometry,
  });

  String? type;
  FeatureProperties? properties;
  Geometry? geometry;

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
    type:json["type"],
    properties: FeatureProperties.fromJson(json["properties"]),
    geometry: Geometry.fromJson(json["geometry"]),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "properties": properties?.toJson(),
    "geometry": geometry?.toJson(),
  };
}

class Geometry {
  Geometry({
    this.type,
    this.coordinates,
  });

  String? type;
  List<List<List<double>>>? coordinates;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
    type: json["type"],
    coordinates: List<List<List<double>>>.from(json["coordinates"].map((x) => List<List<double>>.from(x.map((x) => List<double>.from(x.map((x) => x.toDouble())))))),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "coordinates": List<dynamic>.from(coordinates!.map((x) => List<dynamic>.from(x.map((x) => List<dynamic>.from(x.map((x) => x)))))),
  };
}

class FeatureProperties {
  FeatureProperties({
    this.id,
    this.warna,
  });

  int? id;
  String? warna;

  factory FeatureProperties.fromJson(Map<String, dynamic> json) => FeatureProperties(
    id: json["Id"],
    warna: json["warna"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "warna": warna,
  };
}

