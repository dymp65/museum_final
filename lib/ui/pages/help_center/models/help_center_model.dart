class HelpCenterModel {
  HelpCenterModel({
    this.slug,
    this.question,
    this.answer,
  });

  String? slug;
  String? question;
  String? answer;

  factory HelpCenterModel.fromJson(Map<String, dynamic> json) =>
      HelpCenterModel(
        slug: json["slug"],
        question: json["question"],
        answer: json["answer"],
      );

  Map<String, dynamic> toJson() => {
        "slug": slug,
        "question": question,
        "answer": answer,
      };
}
