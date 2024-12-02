import 'package:flutter/material.dart';
import 'package:wordpress_app/api/api_service.dart';
import 'package:wordpress_app/models/woocommerce/create_order_model.dart';

class OrderProvider with ChangeNotifier {
  APIService? _apiService;

  bool isLoading = false;

  bool? _isOrderCreated;
  bool? get isOrderCreated => _isOrderCreated;

  Future<void> createOrderProvider(CreateOrderModel createOrderModel) async {
    _isOrderCreated = await _apiService?.createOrder(createOrderModel);
    notifyListeners();
  }

  void initializeData() {
    _apiService = APIService();
  }
}
