import 'dart:convert';

CustomerDetailsModel retrieveCustomerModelFromJson(String str) =>
    CustomerDetailsModel.fromJson(json.decode(str));

String retrieveCustomerModelToJson(CustomerDetailsModel data) =>
    json.encode(data.toJson());

class CustomerDetailsModel {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? username;
  Ing? billing;
  Ing? shipping;
  String? avatarUrl;

  CustomerDetailsModel({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.username,
    this.billing,
    this.shipping,
    this.avatarUrl,
  });

  factory CustomerDetailsModel.fromJson(Map<String, dynamic> json) =>
      CustomerDetailsModel(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        username: json["username"],
        billing: json["billing"] == null ? null : Ing.fromJson(json["billing"]),
        shipping:
            json["shipping"] == null ? null : Ing.fromJson(json["shipping"]),
        avatarUrl: json["avatar_url"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName ?? "",
        "last_name": lastName ?? "",
        "username": username ?? "",
        "billing": billing?.toJson(),
        "shipping": shipping?.toJson(),
      };
}

class Ing {
  String? firstName;
  String? lastName;
  String? company;
  String? address1;
  String? address2;
  String? city;
  String? postcode;
  String? country;
  String? state;
  String? email;
  String? phone;

  Ing({
    this.firstName,
    this.lastName,
    this.company,
    this.address1,
    this.address2,
    this.city,
    this.postcode,
    this.country,
    this.state,
    this.email,
    this.phone,
  });

  factory Ing.fromJson(Map<String, dynamic> json) => Ing(
        firstName: json["first_name"],
        lastName: json["last_name"],
        company: json["company"],
        address1: json["address_1"],
        address2: json["address_2"],
        city: json["city"],
        postcode: json["postcode"],
        country: json["country"],
        state: json["state"],
        email: json["email"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName ?? "",
        "last_name": lastName ?? "",
        "company": company ?? "",
        "address_1": address1 ?? "",
        "address_2": address2 ?? "",
        "city": city ?? "",
        "postcode": postcode ?? "",
        "country": country ?? "",
        "state": state ?? "",
        "email": email ?? "",
        "phone": phone ?? "",
      };
}
