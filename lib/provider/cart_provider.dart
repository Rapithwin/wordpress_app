import 'package:flutter/material.dart';
import 'package:wordpress_app/api/api_service.dart';
import 'package:wordpress_app/models/woocommerce/cart/addtocart_request_model.dart';
import 'package:wordpress_app/models/woocommerce/cart/get_items_cart_model.dart';

class CartProvider with ChangeNotifier {
  late APIService _apiService;
  bool isLoading = false;

  // Products in cart
  List<CartItemsModel>? _cartItems = <CartItemsModel>[];
  List<CartItemsModel>? get cartItems => _cartItems;

  // Add to cart response
  String? _addCartRes;
  String? get addCartRes => _addCartRes;

  Future<void> addToCart(
      AddCartRequestModel model, Function onCallBalck) async {
    final response = await _apiService.addToCart(model);
    onCallBalck(response);
    notifyListeners();
  }

  Future<void> getItemsInCartProvider() async {
    isLoading = true;
    notifyListeners();
    final response = await _apiService.getItemsInCart();
    _cartItems = response;
    isLoading = false;
    notifyListeners();
  }

  void initializeData() {
    _apiService = APIService();
    _cartItems = <CartItemsModel>[];
  }
}
