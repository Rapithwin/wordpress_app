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

  // Update cart response
  bool? _cartUpdated;
  bool? get cartUpdated => _cartUpdated;

  // Delete item response
  bool? _itemDeleted;
  bool? get itemDeleted => _itemDeleted;

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

  Future<void> updateCartProvider(
      String itemKey, String quantity, Function onCallBalck) async {
    final response = await _apiService.updateCart(itemKey, quantity);
    _cartUpdated = response;
    onCallBalck(response);
    notifyListeners();
  }

  Future<void> deleteItemProvider(String itemKey, Function onCallBalck) async {
    final response = await _apiService.deleteItemCart(itemKey);
    _itemDeleted = response;
    onCallBalck(response);
    notifyListeners();
  }

  void initializeData() {
    _apiService = APIService();
    _cartItems = <CartItemsModel>[];
  }
}
