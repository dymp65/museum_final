class MetaModel {
  dynamic page;
  dynamic total;
  dynamic per_page;
  dynamic total_pages;

  MetaModel({
    this.page,
    this.total,
    this.per_page,
    this.total_pages,
  });

  factory MetaModel.fromJson(Map<String, dynamic> json) => MetaModel(
        page: json["page"],
        total: json["total"],
        per_page: json["per_page"],
        total_pages: json["total_pages"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "total": total,
        "per_page": per_page,
        "total_page": total_pages,
      };
}
