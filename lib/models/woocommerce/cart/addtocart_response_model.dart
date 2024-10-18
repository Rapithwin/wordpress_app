class AddCartResponseModel {
  String? cartKey;
  List<CartItems>? items;

  AddCartResponseModel({this.cartKey, this.items});

  AddCartResponseModel.fromJson(Map<String, dynamic> json) {
    AddCartResponseModel(
      cartKey: json["cart_key"],
      items: List<CartItems>.from(
        json["items"].map(
          (item) => CartItems.fromJson(item),
        ),
      ),
    );
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data["cart_key"] = cartKey;
    data["items"] = items;
    return data;
  }
}

class CartItems {
  String? itemKey;

  CartItems({this.itemKey});

  CartItems.fromJson(Map<String, dynamic> json) {
    CartItems(itemKey: json["item_key"]);
  }

  CartItems.toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data["item_key"] = itemKey;
  }
}
