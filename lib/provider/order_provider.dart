import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordpress_app/api/api_service.dart';
import 'package:wordpress_app/models/woocommerce/create_order_model.dart';
import 'package:wordpress_app/models/woocommerce/customer_details_model.dart';

class OrderProvider with ChangeNotifier {
  APIService? _apiService;

  bool isLoading = false;

  bool _isOrderCreated = false;
  bool get isOrderCreated => _isOrderCreated;

  CreateOrderModel? _orderModel;
  CreateOrderModel? get orderModel => _orderModel;

  Future<void> createOrderProvider(CreateOrderModel createOrderModel) async {
    _orderModel?.shipping ??= Ing();
    _isOrderCreated = (await _apiService?.createOrder(createOrderModel))!;
    notifyListeners();
  }

  void initializeData() {
    _apiService = APIService();
  }
}
