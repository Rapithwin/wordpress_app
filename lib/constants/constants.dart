import 'package:flutter/material.dart';

class WoocommerceInfo {
  // Woocommerce base url
  static String baseUrl = "https://10.0.2.2/wordpress/wp-json/wc/v3/";
  static String postsUrl = "https://10.0.2.2/wordpress/wp-json/wp/v2/posts";
  // JWT url
  static String jwtUrl =
      "https://10.0.2.2/wordpress//wp-json/jwt-auth/v1/token";
  // Endpoints
  static String costumerURL = "customers";
  static String productsURL = "products";
  static String productsCategoriesURL = "products/categories";
}

class Constants {
  static const primaryColor = Color(0xFF296e48);
  static const blackColor = Colors.black;

  static String titleOne = "گیاهان را بهتر از قبل درک کن";
  static String descriptionOne =
      "درمورد نگهداری گل و گیاهان می‌تونی اطلاعات کسب کنی";
  static String titleTwo = "با گیاهان جدید آشنا شو";
  static String descriptionTwo =
      "رز مشکی یا گل رز دوست داری؟ اینجا می‌تونی پیداش کنی";
  static String titleThree = "با یک گل بهار نمی‌شه، گل بکار";
  static String descriptionThree =
      "هر گلی که نیاز داشته باشید در این اپلیکیشن پیدا می‌کنید";

  static List<String> plantTypes = [
    "|پیشنهادی|",
    "|آپارتمانی|",
    "|محل کار|",
    "|باغچه‌ای|",
  ];
}
