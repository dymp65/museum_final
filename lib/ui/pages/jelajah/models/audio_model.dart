class AudioModel {
  AudioModel({
    this.id,
    this.name,
    this.media,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? media;
  // DateTime? updatedAt;
  String? updatedAt;

  factory AudioModel.fromJson(Map<String, dynamic> json) => AudioModel(
        id: json["id"],
        name: json["name"],
        media: json["media"],
        // updatedAt: DateTime.parse(json["updated_at"]),
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "media": media,
        // "updated_at": updatedAt?.toIso8601String(),
        "updated_at": updatedAt,
      };
}
