import 'package:flutter/material.dart';

class WoocommerceInfo {
  // Woocommerce base url
  static String baseUrl = "https://10.0.2.2/wordpress/wp-json/wc/v3/";
  // Wordpress base url
  static String wordpressUrl = "https://10.0.2.2/wordpress/wp-json/";
  // JWT url
  static String jwtUrl =
      "https://10.0.2.2/wordpress//wp-json/jwt-auth/v1/token";
  // CoCart url
  static String coCartUrl = "cocart/v2/cart/";
  // Endpoints
  static String customerURL = "customers";
  static String productsURL = "products";
  static String productsCategoriesURL = "products/categories";
  static String postsUrl = "wp/v2/posts/";
  // CoCart add item endpoint
  static String addItemToCart = "add-item";
  // CoCart items endpoint
  static String items = "items";
  // CoCart item endpoint
  static String item = "item";
  // CoCart clear cart
  static String clear = "clear";

  // Order endpoint
  static String order = "orders";
}

class Constants {
  static const primaryColor = Color(0xFF296e48);
  static const blackColor = Colors.black;
}
