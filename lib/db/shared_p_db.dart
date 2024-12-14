import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:wordpress_app/models/woocommerce/login_model.dart';

class SharedServices {
  static Future setLoginDetails(LoginModel loginResponseModel) async {
    final sharedPref = await SharedPreferences.getInstance();

    return sharedPref.setString(
        "login_details",
        loginResponseModel.toString().isNotEmpty
            ? jsonEncode(loginResponseModel.toJson())
            : "");
  }

  static Future getLoginDetails() async {
    final sharedPred = await SharedPreferences.getInstance();
    if (sharedPred.getString("login_details").toString().isNotEmpty &&
        sharedPred.getString("login_details") != null) {
      return LoginModel.fromJson(
        jsonDecode(
          sharedPred.getString("login_details").toString(),
        ),
      );
    }
  }

  static Future<bool> isLoggedIn() async {
    final sharedPref = await SharedPreferences.getInstance();

    return sharedPref.getString("login_details") != null;
  }
}
