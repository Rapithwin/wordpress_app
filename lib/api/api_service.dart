import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wordpress_app/constants/constants.dart';
import 'package:wordpress_app/db/shared_p_db.dart';
import 'package:wordpress_app/models/woocommerce/cart/addtocart_request_model.dart';
import 'package:wordpress_app/models/woocommerce/cart/get_items_cart_model.dart';
import 'package:wordpress_app/models/woocommerce/categories_model.dart';
import 'package:wordpress_app/models/posts_model.dart';
import 'package:wordpress_app/models/woocommerce/order_model.dart';
import 'package:wordpress_app/models/woocommerce/customer_model.dart';
import 'package:wordpress_app/models/woocommerce/customer_details_model.dart';
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

  Future<bool> createCustomer(CustomerModel model) async {
    bool isCreated = false;
    Dio dio = Dio(options);
    String url = "${WoocommerceInfo.baseUrl}${WoocommerceInfo.customerURL}";

    try {
      var response = await dio.request(
        url,
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

  Future<LoginModel?> loginCustomer(
    String username,
    String password,
  ) async {
    Dio dio = Dio(options);
    String url = WoocommerceInfo.jwtUrl;

    LoginModel? loginModel;

    try {
      var response = await dio.request(
        url,
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
        "${WoocommerceInfo.baseUrl}${WoocommerceInfo.productsURL}",
        queryParameters: {
          "category": catId ?? "",
        },
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
    String url = "${WoocommerceInfo.baseUrl}${WoocommerceInfo.productsURL}/$id";

    try {
      var response = await Dio().request(
        url,
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
    String url =
        "${WoocommerceInfo.baseUrl}${WoocommerceInfo.productsCategoriesURL}";

    try {
      var response = await Dio().request(
        url,
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
    String url = "${WoocommerceInfo.wordpressUrl}${WoocommerceInfo.postsUrl}";

    try {
      var response = await Dio().request(
        url,
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
    String url =
        "${WoocommerceInfo.postsUrl}${WoocommerceInfo.wordpressUrl}$id!";

    try {
      var response = await Dio().request(
        url,
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

    try {
      var response = await Dio().request(
        "${WoocommerceInfo.baseUrl}${WoocommerceInfo.productsURL}",
        queryParameters: {
          "page": pageNumber ?? "",
          "per_page": pageSize ?? "",
          "search": searchKeyword ?? "",
          "tag": tagName ?? "",
          "orderby": sortBy ?? "",
          "order": sortOrder,
        },
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
    LoginModel? loginResponseModel = await SharedServices.getLoginDetails();
    String cartAuthToken = loginResponseModel!.token!;
    String url =
        "${WoocommerceInfo.wordpressUrl}${WoocommerceInfo.coCartUrl}${WoocommerceInfo.addItemToCart}";

    try {
      var response = await Dio().request(
        url,
        data: model.toJson(),
        options: Options(
          method: "POST",
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $cartAuthToken",
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
    LoginModel? loginResponseModel = await SharedServices.getLoginDetails();
    String cartAuthToken = loginResponseModel!.token!;
    String url =
        "${WoocommerceInfo.wordpressUrl}${WoocommerceInfo.coCartUrl}${WoocommerceInfo.items}";

    try {
      var response = await Dio().request(
        url,
        options: Options(
          method: "GET",
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $cartAuthToken",
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

      if (e.response?.statusCode == 404) itemsInCart = <CartItemsModel>[];
    }
    return itemsInCart;
  }

  Future<bool> updateCart(String itemKey, String quantity) async {
    late bool cartUpdated;
    LoginModel? loginResponseModel = await SharedServices.getLoginDetails();
    String cartAuthToken = loginResponseModel!.token!;
    String url =
        "${WoocommerceInfo.wordpressUrl}${WoocommerceInfo.coCartUrl}${WoocommerceInfo.item}/$itemKey";

    try {
      var response = await Dio().request(
        url,
        data: {"quantity": quantity},
        options: Options(
          method: "POST",
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $cartAuthToken",
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );
      if (response.statusCode == 200) {
        cartUpdated = true;
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        debugPrint("Timeout Error");
        cartUpdated = false;
      }
      debugPrint(e.message);
      cartUpdated = false;
    }
    return cartUpdated;
  }

  Future<bool> deleteItemCart(String itemKey) async {
    late bool itemDeleted;
    LoginModel? loginResponseModel = await SharedServices.getLoginDetails();
    String cartAuthToken = loginResponseModel!.token!;
    String url =
        "${WoocommerceInfo.wordpressUrl}${WoocommerceInfo.coCartUrl}${WoocommerceInfo.item}/$itemKey";

    try {
      var response = await Dio().request(
        url,
        options: Options(
          method: "DELETE",
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $cartAuthToken",
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );
      if (response.statusCode == 200) {
        itemDeleted = true;
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        debugPrint("Timeout Error");
        itemDeleted = false;
      }
      debugPrint(e.message);
      itemDeleted = false;
    }
    return itemDeleted;
  }

  Future<bool> clearCart() async {
    late bool cartCleared;
    LoginModel? loginResponseModel = await SharedServices.getLoginDetails();
    String cartAuthToken = loginResponseModel!.token!;
    String url =
        "${WoocommerceInfo.wordpressUrl}${WoocommerceInfo.coCartUrl}${WoocommerceInfo.clear}";

    try {
      var response = await Dio().request(
        url,
        options: Options(
          method: "POST",
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $cartAuthToken",
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );
      if (response.statusCode == 200) {
        cartCleared = true;
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        debugPrint("Timeout Error");
        cartCleared = false;
      }
      debugPrint(e.message);
      cartCleared = false;
    }
    return cartCleared;
  }

  Future<CustomerDetailsModel?> getCustomerDetails() async {
    CustomerDetailsModel? responseModel;
    LoginModel? loginResponseModel = await SharedServices.getLoginDetails();
    int userID = loginResponseModel!.userId!;
    String url =
        "${WoocommerceInfo.baseUrl}${WoocommerceInfo.customerURL}/$userID";
    try {
      var response = await Dio().request(
        url,
        options: Options(
          method: "GET",
          headers: {
            HttpHeaders.authorizationHeader: "Basic $authToken",
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );
      if (response.statusCode == 200) {
        responseModel = CustomerDetailsModel.fromJson(response.data);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        debugPrint("Timeout Error");
      }
      debugPrint(e.message);
    }
    return responseModel;
  }

  Future<CustomerDetailsModel?> updateCustomerDetails(
      CustomerDetailsModel model) async {
    CustomerDetailsModel? responseModel;
    LoginModel? loginResponseModel = await SharedServices.getLoginDetails();
    int userID = loginResponseModel!.userId!;
    String url =
        "${WoocommerceInfo.baseUrl}${WoocommerceInfo.customerURL}/$userID";
    try {
      var response = await Dio().request(
        url,
        data: model.toJson(),
        options: Options(
          method: "POST",
          headers: {
            HttpHeaders.authorizationHeader: "Basic $authToken",
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );
      if (response.statusCode == 200) {
        responseModel = CustomerDetailsModel.fromJson(response.data);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        debugPrint("Timeout Error");
      }
      debugPrint(e.response.toString());
    }
    return responseModel;
  }

  Future<bool> createOrder(OrderModel model) async {
    bool isOrderCreated = false;
    LoginModel? loginResponseModel = await SharedServices.getLoginDetails();
    model.customerId = loginResponseModel?.userId;
    String url = "${WoocommerceInfo.baseUrl}${WoocommerceInfo.order}";
    try {
      var response = await Dio().request(
        url,
        data: model.toJson(),
        options: Options(
          sendTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          method: "POST",
          headers: {
            HttpHeaders.authorizationHeader: "Basic $authToken",
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );
      if (response.statusCode == 201) {
        isOrderCreated = true;
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        debugPrint("Timeout Error");
        isOrderCreated = false;
      }
      debugPrint(e.response.toString());

      isOrderCreated = false;
    }
    return isOrderCreated;
  }

  Future<List<OrderModel>> getAllOrders(String? status) async {
    List<OrderModel> ordersList = <OrderModel>[];
    LoginModel? loginResponseModel = await SharedServices.getLoginDetails();
    int? userId = loginResponseModel?.userId;

    try {
      var response = await Dio().request(
        "${WoocommerceInfo.baseUrl}${WoocommerceInfo.order}",
        queryParameters: {
          "status": status ?? "",
          "customer": userId,
        },
        options: Options(
          sendTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          method: "GET",
          headers: {
            HttpHeaders.authorizationHeader: "Basic $authToken",
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );
      if (response.statusCode == 200) {
        ordersList =
            (response.data as List).map((i) => OrderModel.fromJson(i)).toList();
        debugPrint(ordersList.toString());
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        debugPrint("Timeout Error");
      }
      debugPrint(e.response.toString());

      ordersList = <OrderModel>[];
    }
    return ordersList;
  }
}
