class CustomerModel {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;

  CustomerModel({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json.addAll({
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "password": password,
    });
    return json;
  }
}
