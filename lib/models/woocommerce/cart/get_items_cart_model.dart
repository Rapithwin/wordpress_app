import 'dart:convert';

Map<String, CartItemsModel> cartItemsModelFromJson(String str) =>
    Map.from(json.decode(str)).map((k, v) =>
        MapEntry<String, CartItemsModel>(k, CartItemsModel.fromJson(v)));

String cartItemsModelToJson(Map<String, CartItemsModel> data) => json.encode(
    Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class CartItemsModel {
  String? itemKey;
  int? id;
  String? title;
  String? price;
  Quantity? quantity;
  Totals? totals;
  String? featuredImage;

  CartItemsModel({
    this.itemKey,
    this.id,
    this.title,
    this.price,
    this.quantity,
    this.totals,
    this.featuredImage,
  });

  factory CartItemsModel.fromJson(Map<String, dynamic> json) => CartItemsModel(
        itemKey: json["item_key"],
        id: json["id"],
        title: json["title"],
        price: json["price"],
        quantity: json["quantity"] == null
            ? null
            : Quantity.fromJson(json["quantity"]),
        totals: json["totals"] == null ? null : Totals.fromJson(json["totals"]),
        featuredImage: json["featured_image"],
      );

  Map<String, dynamic> toJson() => {
        "item_key": itemKey,
        "id": id,
        "title": title,
        "price": price,
        "quantity": quantity?.toJson(),
        "totals": totals?.toJson(),
        "featured_image": featuredImage,
      };
}

class Quantity {
  int? value;

  Quantity({
    this.value,
  });

  factory Quantity.fromJson(Map<String, dynamic> json) => Quantity(
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
      };
}

class Totals {
  int? total;

  Totals({
    this.total,
  });

  factory Totals.fromJson(Map<String, dynamic> json) => Totals(
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
      };
}
