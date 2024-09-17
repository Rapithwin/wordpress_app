import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wordpress_app/constants/constants.dart';
import 'package:wordpress_app/models/woocommerce/costumer_model.dart';
import 'package:wordpress_app/models/woocommerce/login_model.dart';

class APIService {
  final String consumerKey = dotenv.env["CONSUMER_KEY"]!;
  final String consumerSecret = dotenv.env["CONSUMER_SECRET"]!;

  Future<bool> createCostumer(CustomerModel model) async {
    bool isCreated = false;
    final String authToken =
        base64.encode(utf8.encode("$consumerKey:$consumerSecret"));

    try {
      var response = await Dio()
          .request(
            WoocommerceInfo.baseUrl + WoocommerceInfo.costumerURL,
            data: model.toJson(),
            options: Options(
              method: "POST",
              headers: {
                HttpHeaders.authorizationHeader: "Basic $authToken",
                HttpHeaders.contentTypeHeader: "application/json",
              },
            ),
          )
          .timeout(
            const Duration(seconds: 180),
          );
      if (response.statusCode == 201) {
        isCreated = true;
      }
    } on DioException catch (e) {
      isCreated = false;
      debugPrint(e.toString());
    }
    return isCreated;
  }

  Future<LoginModel> loginCustomer(
    String username,
    String password,
  ) async {
    late LoginModel loginModel;

    try {
      var response = await Dio().request(
        WoocommerceInfo.jwtUrl,
        data: {
          "username": username,
          "password": password,
        },
        options: Options(
          method: "POST",
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );
      if (response.statusCode == 200) {
        loginModel = LoginModel.fromJson(response.data);
      }
    } on DioException catch (e) {
      debugPrint(e.message);
    }
    return loginModel;
  }
}
