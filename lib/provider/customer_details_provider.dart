import 'package:flutter/material.dart';
import 'package:wordpress_app/api/api_service.dart';
import 'package:wordpress_app/models/woocommerce/customer_details_model.dart';

class CustomerDetailsProvider with ChangeNotifier {
  APIService? _apiService;

  bool isLoading = false;

  CustomerDetailsProvider() {
    _apiService = APIService();
  }
  CustomerDetailsModel? _customerDetailsModel;
  CustomerDetailsModel? get customerDetailsModel => _customerDetailsModel;

  Future<void> fetchShippingDetails() async {
    _customerDetailsModel ??= CustomerDetailsModel();
    _customerDetailsModel = await _apiService?.getCustomerDetails();
    notifyListeners();
  }

  Future<void> updateCustomerDetails(
      CustomerDetailsModel customerDetailsModel) async {
    isLoading = true;
    notifyListeners();
    _customerDetailsModel ??= CustomerDetailsModel();
    _customerDetailsModel =
        await _apiService?.updateCustomerDetails(customerDetailsModel);
    isLoading = false;
    notifyListeners();
  }

  void initializeData() {
    _apiService = APIService();
  }
}
