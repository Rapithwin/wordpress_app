import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordpress_app/api/api_service.dart';
import 'package:wordpress_app/models/woocommerce/create_order_model.dart';
import 'package:wordpress_app/models/woocommerce/customer_details_model.dart';
import 'package:wordpress_app/models/woocommerce/cart/get_items_cart_model.dart';
import 'package:wordpress_app/provider/cart_provider.dart';
import 'package:wordpress_app/provider/customer_details_provider.dart';

class OrderProvider with ChangeNotifier {
  APIService? _apiService;
  OrderProvider() {
    _apiService = APIService();
  }
  bool isLoading = false;

  bool _isOrderCreated = false;
  bool get isOrderCreated => _isOrderCreated;

  OrderModel? _orderModel;
  OrderModel? get orderModel => _orderModel;

  List<OrderModel>? _ordersList;
  List<OrderModel>? get ordersList => _ordersList;

  Future<void> createOrderProvider(
      OrderModel createOrderModel, BuildContext context) async {
    _orderModel?.shipping ??= Ing();

    createOrderModel.lineItems ??= [];
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);

    List<CartItemsModel> itemsInCart = cartProvider.cartItems!;
    for (var item in itemsInCart) {
      createOrderModel.lineItems?.add(
        LineItems(
          quantity: item.quantity?.value,
          productId: item.id,
        ),
      );
    }

    CustomerDetailsModel? customerDetails =
        Provider.of<CustomerDetailsProvider>(context, listen: false)
            .customerDetailsModel;

    if (customerDetails != null) {
      createOrderModel.shipping = customerDetails.shipping;
    }

    _isOrderCreated = (await _apiService?.createOrder(createOrderModel))!;
    cartProvider.clearCartProvider();
    notifyListeners();
  }

  Future<void> getAllOrdersProvider() async {
    isLoading = true;
    notifyListeners();
    _ordersList = await _apiService?.getAllOrders();
    isLoading = false;
    notifyListeners();
  }

  void proccessOrder(OrderModel createOrderModel) {
    _orderModel = createOrderModel;
    notifyListeners();
  }

  void initializeData() {
    _apiService = APIService();
  }
}
