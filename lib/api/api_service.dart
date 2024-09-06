import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wordpress_app/constants/constants.dart';
import 'package:wordpress_app/models/woocommerce/costumer_model.dart';

class APIService {
  final String consumerKey = dotenv.env["CONSUMER_KEY"]!;
  final String consumerSecret = dotenv.env["CONSUMER_SECRET"]!;

  Future<bool> createCostumer(CustomerModel model) async {
    bool isCreated = false;
    final String authToken =
        base64.encode(utf8.encode("$consumerKey:$consumerSecret"));

    try {
      var response = await Dio().request(
        WoocommerceInfo.baseUrl + WoocommerceInfo.costumerURL,
        data: model.toJson(),
        options: Options(
          method: "POST",
          headers: {HttpHeaders.authorizationHeader: "Basic $authToken"},
        ),
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
}
