class AddCartRequestModel {
  String? id;
  String? quantity;

  AddCartRequestModel({this.id, this.quantity});

  AddCartRequestModel.fromJson(Map<String, dynamic> json) {
    AddCartRequestModel(
      id: json["id"],
      quantity: json["quantity"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
      };
}
