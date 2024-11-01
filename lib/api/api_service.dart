import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wordpress_app/constants/constants.dart';
import 'package:wordpress_app/models/woocommerce/cart/addtocart_request_model.dart';
import 'package:wordpress_app/models/woocommerce/cart/get_items_cart_model.dart';
import 'package:wordpress_app/models/woocommerce/categories_model.dart';
import 'package:wordpress_app/models/posts_model.dart';
import 'package:wordpress_app/models/woocommerce/costumer_model.dart';
import 'package:wordpress_app/models/woocommerce/login_model.dart';
import 'package:wordpress_app/models/woocommerce/products_model.dart';

final String consumerKey = dotenv.env["CONSUMER_KEY"]!;
final String consumerSecret = dotenv.env["CONSUMER_SECRET"]!;

class APIService {
  final String authToken =
      base64.encode(utf8.encode("$consumerKey:$consumerSecret"));

  BaseOptions options = BaseOptions(
    baseUrl: "https://10.0.2.2/",
    receiveDataWhenStatusError: true,
    connectTimeout: const Duration(seconds: 45),
    receiveTimeout: const Duration(seconds: 45),
  );

  Future<bool> createCostumer(CustomerModel model) async {
    bool isCreated = false;
    Dio dio = Dio(options);

    try {
      var response = await dio.request(
        WoocommerceInfo.baseUrl + WoocommerceInfo.costumerURL,
        data: model.toJson(),
        options: Options(
          method: "POST",
          headers: {
            HttpHeaders.authorizationHeader: "Basic $authToken",
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );

      if (response.statusCode == 201) {
        isCreated = true;
      }
    } on DioException catch (e) {
      isCreated = false;
      if (e.type == DioExceptionType.connectionTimeout) {
        throw "Connection Timeout";
      }
      debugPrint(e.message);
    }
    return isCreated;
  }

  Future<LoginModel> loginCustomer(
    String username,
    String password,
  ) async {
    Dio dio = Dio(options);

    late LoginModel loginModel;

    try {
      var response = await dio.request(
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
      if (e.type == DioExceptionType.connectionTimeout) {
        debugPrint("Timeout Error");
      }
      debugPrint(e.message);
    }
    return loginModel;
  }

  Future<List<ProductModel>> getAllProducts(String? catId) async {
    List<ProductModel> productsList = <ProductModel>[];

    try {
      var response = await Dio().request(
        catId != null
            ? "${WoocommerceInfo.baseUrl}${WoocommerceInfo.productsURL}?category=$catId"
            : "${WoocommerceInfo.baseUrl}${WoocommerceInfo.productsURL}",
        options: Options(
          method: "GET",
          headers: {
            HttpHeaders.authorizationHeader: "Basic $authToken",
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );
      if (response.statusCode == 200) {
        productsList = (response.data as List)
            .map((i) => ProductModel.fromJson(i))
            .toList();
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        debugPrint("Timeout Error");
      }
      debugPrint(e.message);
    }
    return productsList;
  }

  Future<ProductModel> getProductById(String id) async {
    late ProductModel product;
    try {
      var response = await Dio().request(
        "${WoocommerceInfo.baseUrl}${WoocommerceInfo.productsURL}/$id",
        options: Options(
          method: "GET",
          headers: {
            HttpHeaders.authorizationHeader: "Basic $authToken",
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );
      if (response.statusCode == 200) {
        product = ProductModel.fromJson(response.data);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        debugPrint("Timeout Error");
      }
      debugPrint(e.message);
    }
    return product;
  }

  Future<List<CategoriesModel>> getProductCategories() async {
    List<CategoriesModel> productCategoriesList = <CategoriesModel>[];

    try {
      var response = await Dio().request(
        WoocommerceInfo.baseUrl + WoocommerceInfo.productsCategoriesURL,
        options: Options(
          method: "GET",
          headers: {
            HttpHeaders.authorizationHeader: "Basic $authToken",
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );
      if (response.statusCode == 200) {
        productCategoriesList = (response.data as List)
            .map((i) => CategoriesModel.fromJson(i))
            .toList();
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        debugPrint("Timeout Error");
      }
      debugPrint(e.message);
    }
    return productCategoriesList;
  }

  Future<List<Posts>?> getAllPosts() async {
    List<Posts> postsList = <Posts>[];

    try {
      var response = await Dio().request(
        WoocommerceInfo.wordpressUrl + WoocommerceInfo.postsUrl,
        options: Options(
          method: "GET",
          headers: {
            HttpHeaders.authorizationHeader: "Basic $authToken",
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );
      if (response.statusCode == 200) {
        postsList =
            (response.data as List).map((i) => Posts.fromJson(i)).toList();
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        debugPrint("Timeout Error");
      }
      debugPrint(e.message);
    }
    return postsList;
  }

  Future<Posts> getPostById(String? id) async {
    late Posts post;
    try {
      var response = await Dio().request(
        WoocommerceInfo.postsUrl + WoocommerceInfo.wordpressUrl + id!,
        options: Options(
          method: "GET",
          headers: {
            HttpHeaders.authorizationHeader: "Basic $authToken",
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );
      if (response.statusCode == 200) {
        post = Posts.fromJson(response.data);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        debugPrint("Timeout Error");
      }
      debugPrint(e.message);
    }
    return post;
  }

  Future<List<ProductModel>> getCatalog({
    int? pageNumber,
    int? pageSize,
    String? searchKeyword,
    String? tagName,
    String? sortBy,
    String sortOrder = "desc",
  }) async {
    List<ProductModel> productList = <ProductModel>[];
    String parameter = "";
    if (pageNumber != null) {
      parameter += "&page=$pageNumber";
    }
    if (pageSize != null) {
      parameter += "&per_page=$pageSize";
    }
    if (searchKeyword != null) {
      parameter += "&search=$searchKeyword";
    }
    if (tagName != null) {
      parameter += "&tag=$tagName";
    }
    if (sortBy != null) {
      parameter += "&orderby=$sortBy";
    }
    if (sortOrder == "asc") {
      parameter += "&order=asc";
    }
    parameter.replaceFirst("&", "");
    final String productUrl =
        "${WoocommerceInfo.baseUrl}${WoocommerceInfo.productsURL}?$parameter";
    try {
      var response = await Dio().request(
        productUrl,
        options: Options(
          method: "GET",
          headers: {
            HttpHeaders.authorizationHeader: "Basic $authToken",
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        productList = (response.data as List)
            .map((i) => ProductModel.fromJson(i))
            .toList();
      }
    } on DioException catch (e) {
      debugPrint(e.message);
    }
    return productList;
  }


Future<String> addToCart(AddCartRequestModel model) async {
  late String cartResponse;
  // TODO
  String cartAuthToken = base64.encode(utf8.encode("api_test:12345678"));

  try {
    var response = await Dio().request(
      WoocommerceInfo.wordpressUrl +
          WoocommerceInfo.coCartUrl +
          WoocommerceInfo.addItemToCart,
      data: model.toJson(),
      options: Options(
        method: "POST",
        headers: {
          HttpHeaders.authorizationHeader: "Basic $cartAuthToken",
          HttpHeaders.contentTypeHeader: "application/json",
        },
      ),
    );
    if (response.statusCode == 200) {
      cartResponse = "به سبد خرید اضافه شد";
    }
  } on DioException catch (e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      debugPrint("Timeout Error");
    }
    debugPrint(e.message);
    cartResponse = "مشکلی رخ داده است";
  }
  return cartResponse;
}

Future<List<CartItemsModel>> getItemsInCart() async {
  late List<CartItemsModel> itemsInCart;
  // TODO
  String cartAuthToken = base64.encode(utf8.encode("api_test:12345678"));

  try {
    var response = await Dio().request(
      WoocommerceInfo.wordpressUrl +
          WoocommerceInfo.coCartUrl +
          WoocommerceInfo.items,
      options: Options(
        method: "GET",
        headers: {
          HttpHeaders.authorizationHeader: "Basic $cartAuthToken",
          HttpHeaders.contentTypeHeader: "application/json",
        },
      ),
    );
    if (response.statusCode == 200) {
      var decodedJson = cartItemsModelFromJson(json.encode(response.data));
      itemsInCart = decodedJson.values.toList();
    }
  } on DioException catch (e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      debugPrint("Timeout Error");
    }
    debugPrint(e.message);
  }
  return itemsInCart;
}
