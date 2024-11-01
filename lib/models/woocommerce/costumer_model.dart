class CustomerModel {
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? username;

  CustomerModel({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.username,
  });

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "password": password,
        "username": username,
      };
}
