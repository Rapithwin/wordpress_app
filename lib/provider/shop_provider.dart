import 'package:flutter/widgets.dart';
import 'package:wordpress_app/api/api_service.dart';
import 'package:wordpress_app/models/woocommerce/categories_model.dart';
import 'package:wordpress_app/models/posts_model.dart';
import 'package:wordpress_app/models/woocommerce/products_model.dart';

class ShopProvider extends ChangeNotifier {
  APIService? _apiService;

  bool isLoading = false;
  bool isLoadingPosts = false;
  // Products
  List<ProductModel>? _products = <ProductModel>[];
  List<ProductModel>? get product => _products;

  // Product categories
  List<CategoriesModel>? _categories = <CategoriesModel>[];
  List<CategoriesModel>? get category => _categories;

  // Posts
  List<Posts>? _posts = <Posts>[];
  List<Posts>? get psot => _posts;

  // Posts by id
  Posts? _postById;
  Posts? get postById => _postById;

  ShopProvider() {
    _apiService = APIService();
  }

  Future<void> getAllProducts({String? catId}) async {
    isLoading = true;
    notifyListeners();
    final response = await _apiService?.getAllProducts(catId);
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

  Future<void> getAllPosts() async {
    isLoadingPosts = true;
    notifyListeners();
    final response = await _apiService?.getAllPosts();
    _posts = response;
    isLoadingPosts = false;
    notifyListeners();
  }

  Future<void> getPostById(String id) async {
    isLoadingPosts = true;
    notifyListeners();
    final response = await _apiService?.getPostById(id);
    _postById = response;
    isLoadingPosts = false;
    notifyListeners();
  }

  void initializeData() {
    _apiService = APIService();
  }
}
