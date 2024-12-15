class LoginModel {
  String? token;
  String? email;
  String? username;
  String? displayName;
  String? message;
  String? userId;

  LoginModel({
    this.token,
    this.message,
    this.email,
    this.username,
    this.displayName,
    this.userId,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        token: json["token"],
        email: json["user_email"],
        username: json["user_nicename"],
        displayName: json["user_display_name"],
        message: json["message"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user_email": email,
        "user_nicename": username,
        "user_display_name": displayName,
        "message": message,
        "user_id": userId,
      };
}
