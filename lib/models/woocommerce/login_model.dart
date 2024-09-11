class LoginModel {
  String? token;
  String? email;
  String? username;
  String? displayName;
  String? message;

  LoginModel({
    this.message,
    this.email,
    this.username,
    this.displayName,
  });

  LoginModel.fromJson(Map<String, dynamic> json) {
    token = json["token"];
    email = json["user_email"];
    username = json["user_nicename"];
    displayName = json["user_display_name"];
    message = json["message"];
  }
}
