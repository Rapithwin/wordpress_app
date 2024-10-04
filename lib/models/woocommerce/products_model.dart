class ProductModel {
  int? id;
  bool? purchasable;
  String? name;
  String? description;
  String? shortDescription;
  String? price;
  String? regularPrice;
  List<WooImg>? images;
  List<Categories>? categories;

  ProductModel({
    this.id,
    this.purchasable,
    this.name,
    this.description,
    this.shortDescription,
    this.price,
    this.regularPrice,
    this.images,
    this.categories,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    purchasable = json["purchasable"];
    name = json["name"];
    description = json["description"];
    shortDescription = json["short_description"];
    price = json["price"];
    regularPrice = json["regularPrice"];
    if (json["images"] != null) {
      images = <WooImg>[];
      json["images"].forEach(
        (value) {
          images?.add(WooImg.fromJson(value));
        },
      );
    }
    if (json["categories"] != null) {
      categories = <Categories>[];
      json["categories"].forEach(
        (value) {
          categories?.add(Categories.fromJson(value));
        },
      );
    }
  }
}

class Categories {
  int? id;
  String? name;

  Categories({
    this.id,
    this.name,
  });

  Categories.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
  }
}

class WooImg {
  String? src;

  WooImg({this.src});

  WooImg.fromJson(Map<String, dynamic> json) {
    src = json["src"];
  }
}
