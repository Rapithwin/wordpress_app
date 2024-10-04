import 'package:flutter/widgets.dart';
import 'package:wordpress_app/api/api_service.dart';
import 'package:wordpress_app/models/woocommerce/categories_model.dart';
import 'package:wordpress_app/models/posts_model.dart';
import 'package:wordpress_app/models/woocommerce/products_model.dart';

class ShopProvider extends ChangeNotifier {
  APIService? _apiService;

  bool isLoading = false;
  // Products
  List<ProductModel>? _products = <ProductModel>[];
  List<ProductModel>? get product => _products;

  // Product by id
  ProductModel? _productById;
  ProductModel? get productById => _productById;

  // Product categories
  List<CategoriesModel>? _categories = <CategoriesModel>[];
  List<CategoriesModel>? get category => _categories;

  // Posts
  List<Posts>? _posts = <Posts>[];
  List<Posts>? get psot => _posts;

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

  Future<void> getProductById(String id) async {
    isLoading = true;
    notifyListeners();
    final response = await _apiService?.getProductById(id);
    _productById = response;
    isLoading = false;
    notifyListeners();
  }

  Future<void> getAllPosts() async {
    isLoading = true;
    notifyListeners();
    final response = await _apiService?.getAllPosts();
    _posts = response;
    isLoading = false;
    notifyListeners();
  }

  void initializeData() {
    _apiService = APIService();
  }
}
