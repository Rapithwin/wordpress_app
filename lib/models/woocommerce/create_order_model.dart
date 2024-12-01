import 'package:wordpress_app/models/woocommerce/customer_details_model.dart';

class CreateOrderModel {
  int? customerId;
  int? orderId;
  String? paymentMethod;
  String? paymentMethodTitle;
  bool? setPaid;
  String? transactionId;
  List<LineItems>? lineItems;
  String? orderNumber;
  String? status;
  DateTime? orderDate;
  Ing? shipping;

  CreateOrderModel({
    this.customerId,
    this.paymentMethod,
    this.paymentMethodTitle,
    this.setPaid,
    this.transactionId,
    this.lineItems,
    this.orderId,
    this.orderNumber,
    this.status,
    this.orderDate,
    this.shipping,
  });

  factory CreateOrderModel.fromJson(Map<String, dynamic> json) =>
      CreateOrderModel(
        customerId: json["customer_id"],
        orderId: json["id"],
        orderNumber: json["order_key"],
        status: json["status"],
        orderDate: DateTime.parse(json["date_created"]),
      );

  Map<String, dynamic> toJson() => {
        "customer_id": customerId,
        "payment_method": paymentMethod,
        "payment_method_title": paymentMethodTitle,
        "set_paid": setPaid,
        "transaction_id": transactionId,
        "shipping": shipping?.toJson(),
        "line_items": lineItems?.map((v) => v.toJson()).toList(),
      };
}

class LineItems {
  int? productId;
  int? quantity;
  int? variationId;

  LineItems({
    this.productId,
    this.quantity,
    this.variationId,
  });

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "quantity": quantity,
        "variation_id": variationId,
      };
}
