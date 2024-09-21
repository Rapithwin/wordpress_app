import 'package:flutter/widgets.dart';
import 'package:wordpress_app/api/api_service.dart';
import 'package:wordpress_app/models/categories_model.dart';
import 'package:wordpress_app/models/woocommerce/products_model.dart';

class ShopProvider extends ChangeNotifier {
  APIService? _apiService;

  bool isLoading = false;
  // Products
  List<ProductModel>? _products = <ProductModel>[];
  List<ProductModel>? get product => _products;

  // Product categories
  List<CategoriesModel>? _categories = <CategoriesModel>[];
  List<CategoriesModel>? get category => _categories;

  ShopProvider() {
    _apiService = APIService();
  }

  Future<void> getAllProducts() async {
    isLoading = true;
    notifyListeners();
    final response = await _apiService?.getAllProducts();
    _products = response;
    isLoading = false;
    notifyListeners();
  }

  Future<void> getAllCategories() async {
    isLoading = true;
    notifyListeners();
    final response = await _apiService?.getProductCategories();
    _categories = response;
    isLoading = false;
    notifyListeners();
  }

  void initializeData() {
    _apiService = APIService();
  }
}
