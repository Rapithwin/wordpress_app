class CategoriesModel {
  int? id;
  String? category;

  CategoriesModel({
    this.id,
    this.category,
  });

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    category = json["name"];
  }
}
