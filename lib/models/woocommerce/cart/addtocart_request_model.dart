class AddCartRequestModel {
  int? id;
  int? quantity;

  AddCartRequestModel({this.id, this.quantity});

  AddCartRequestModel.fromJson(Map<String, dynamic> json) {
    AddCartRequestModel(
      id: json["id"],
      quantity: json["quantity"],
    );
  }

  AddCartRequestModel.toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["quantity"] = quantity;
  }
}
