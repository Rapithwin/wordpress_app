class CategoriesModel {
  int? id;
  String? category;

  CategoriesModel({
    this.id,
    this.category,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(
        id: json["id"],
        category: json["name"],
      );
}
