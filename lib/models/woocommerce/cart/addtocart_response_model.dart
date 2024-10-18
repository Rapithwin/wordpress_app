class AddCartResponseModel {
  String? cartKey;
  List<Items>? items;

  AddCartResponseModel({this.cartKey, this.items});

  AddCartResponseModel.fromJson(Map<String, dynamic> json) {
    AddCartResponseModel(
      cartKey: json["cart_key"],
      items: List<Items>.from(
        json["items"].map(
          (item) => Items.fromJson(item),
        ),
      ),
    );
  }
}

class Items {
  String? itemKey;

  Items({this.itemKey});

  Items.fromJson(Map<String, dynamic> json) {
    Items(itemKey: json["item_key"]);
  }
}
