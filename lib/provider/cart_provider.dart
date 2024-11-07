import 'package:flutter/material.dart';
import 'package:wordpress_app/api/api_service.dart';
import 'package:wordpress_app/models/woocommerce/cart/addtocart_request_model.dart';
import 'package:wordpress_app/models/woocommerce/cart/get_items_cart_model.dart';

class CartProvider with ChangeNotifier {
  CartProvider() {
    _apiService = APIService();
    _cartItems = <CartItemsModel>[];
  }
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

  Future<void> getItemsInCartProvider({String? id}) async {
    isLoading = true;
    notifyListeners();
    if (_cartItems == null) initializeData();

    await _apiService.getItemsInCart().then(
      (cartResModel) {
        if (cartResModel.isNotEmpty) {
          _cartItems?.clear();
          List<CartItemsModel> newCartResModel = cartResModel;
          _cartItems?.addAll(newCartResModel);
        }
      },
    );
    isLoading = false;
    notifyListeners();
  }

  Future<void> updateCartProvider(
    String itemKey,
    String quantity,
  ) async {
    final response = await _apiService.updateCart(itemKey, quantity);
    _cartUpdated = response;
    notifyListeners();
  }

  Future<void> deleteItemProvider(String itemKey) async {
    final response = await _apiService.deleteItemCart(itemKey);
    _itemDeleted = response;
    notifyListeners();
  }

  void initializeData() {
    _apiService = APIService();
    _cartItems = <CartItemsModel>[];
  }
}