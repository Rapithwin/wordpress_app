import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wordpress_app/constants/constants.dart';
import 'package:wordpress_app/models/woocommerce/costumer_model.dart';

class APIService {
  final String consumerKey = dotenv.env["CONSUMER_KEY"]!;
  final String consumerSecret = dotenv.env["CONSUMER_SECRET"]!;

  String generateOAuth1Signature(
      String method, Uri uri, Map<String, dynamic> parameters) {
    // Generate a nonce
    final String nonce = DateTime.now().millisecondsSinceEpoch.toString();

    // Generate a timestamp
    final String timestamp =
        (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();

    // Combine OAuth parameters with request parameters
    final Map<String, String> allParameters = {
      'oauth_consumer_key': consumerKey,
      'oauth_signature_method': 'HMAC-SHA1',
      'oauth_timestamp': timestamp,
      'oauth_nonce': nonce,
      'oauth_version': '1.0',
      ...parameters,
    };

    // Sort parameters alphabetically
    final sortedParams = allParameters.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    // Concatenate parameters into a string
    final paramString = sortedParams
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');

    // Generate the base string
    final baseString =
        '$method&${Uri.encodeComponent(uri.toString())}&${Uri.encodeComponent(paramString)}';

    // Generate the signing key
    final signingKey = '$consumerSecret&$consumerKey';

    // Generate the signature
    final hmacSha1 = Hmac(sha1, utf8.encode(signingKey));
    final digest = hmacSha1.convert(utf8.encode(baseString));
    final signature = base64.encode(digest.bytes);

    return signature;
  }

  Future<bool> createCostumer(CustomerModel model) async {
    bool isCreated = false;
    final signature = generateOAuth1Signature(
        'POST', Uri.parse(WoocommerceInfo.baseUrl), model.toJson());

    try {
      var response = await Dio().request(
        WoocommerceInfo.baseUrl + WoocommerceInfo.costumerURL,
        data: model.toJson(),
        options: Options(
          method: "POST",
          headers: {
            HttpHeaders.authorizationHeader:
                'OAuth oauth_consumer_key="$consumerKey",'
                    'oauth_signature_method=HMAC-SHA1,'
                    'oauth_timestamp="${DateTime.now().millisecondsSinceEpoch ~/ 1000}",'
                    'oauth_nonce="${DateTime.now().millisecondsSinceEpoch}",'
                    'oauth_version="1.0", '
                    'oauth_signature="${Uri.encodeComponent(signature)}"',
          },
        ),
      );
      if (response.statusCode == 201) {
        isCreated = true;
      }
    } on DioException catch (e) {
      isCreated = false;
      debugPrint(e.response.toString());
    }
    return isCreated;
  }
}
