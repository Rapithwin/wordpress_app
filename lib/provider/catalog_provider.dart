import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:wordpress_app/api/api_service.dart';
import 'package:wordpress_app/models/woocommerce/products_model.dart';
import 'package:wordpress_app/pages/catalog_page/sort_class.dart';

enum DataStatus {
  initial,
  loading,
  stable,
}

class CatalogProvider with ChangeNotifier {
  late APIService _apiService;
  late List<ProductModel> _productList;
  late SortBy _sortBy;

  int pageSize = 5;
  DataStatus _dataStatus = DataStatus.stable;

  List<ProductModel> get allProducts => _productList;
  double get productLen => _productList.length.toDouble();

  initializeData() {
    _apiService = APIService();
    _productList = [];
  }

  CatalogProvider() {
    initializeData();
    _sortBy = SortBy("modified", "latest", "desc");
  }

  getDataStatus() => _dataStatus;

  setLoadingState(DataStatus dataStatus) {
    _dataStatus = dataStatus;
  }

  setSortOrder(SortBy sortBy) {
    _sortBy = sortBy;
    notifyListeners();
  }

  fetchProducts(
    pageNumber, {
    String? searchKeyword,
    String? tagName,
    String? sortBy,
    String sortOrder = "desc",
  }) async {
    List<ProductModel> itemModel = await _apiService.getCatalog(
      pageNumber: pageNumber,
      searchKeyword: searchKeyword,
      tagName: tagName,
      sortBy: _sortBy.value,
      sortOrder: _sortBy.sortOrder.toString(),
    );
    if (itemModel.isNotEmpty) {
      _productList.addAll(itemModel);
    }
    setLoadingState(DataStatus.stable);
    notifyListeners();
  }
}
