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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["token"] = token;
    data["user_email"] = email;
    data["user_nicename"] = username;
    data["user_display_name"] = displayName;
    data["message"] = message;

    return data;
  }
}
