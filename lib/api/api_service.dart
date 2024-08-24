import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class APIService {
  final String consumerKey = dotenv.env["CONSUMER_KEY"]!;
  final String consumerSecret = dotenv.env["CONSUMER_SECRET"]!;

  String generateOAuth1Signature(
      String method, Uri uri, Map<String, String> parameters) {
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

  Future<bool> createCostumer() async {
    return false;
  }
}
