import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:wordpress_app/constants/constants.dart';
import 'package:wordpress_app/models/woocommerce/cart/get_items_cart_model.dart';
import 'package:wordpress_app/models/woocommerce/create_order_model.dart';
import 'package:wordpress_app/models/woocommerce/customer_details_model.dart';
import 'package:wordpress_app/pages/payment_options/payment_utils.dart';
import 'package:wordpress_app/provider/cart_provider.dart';
import 'package:wordpress_app/provider/customer_details_provider.dart';
import 'package:wordpress_app/utils/custom_appbar.dart';

class PaymentOptionsPage extends StatefulWidget {
  const PaymentOptionsPage({super.key});

  @override
  State<PaymentOptionsPage> createState() => _PaymentOptionsPageState();
}

class _PaymentOptionsPageState extends State<PaymentOptionsPage> {
  late List<CartItemsModel> itemsInCart;
  CreateOrderModel orderModel = CreateOrderModel();
  @override
  void initState() {
    Provider.of<CustomerDetailsProvider>(context, listen: false)
        .fetchShippingDetails();

    itemsInCart = Provider.of<CartProvider>(context, listen: false).cartItems!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.customAppBarAddress(context, "روش پرداخت"),
      bottomNavigationBar: const PaymentButtomAppBar(),
      body: SingleChildScrollView(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: <Widget>[
                const BuildPaymentOptions(
                  icon: Icons.payment,
                  title: "پرداخت آنلاین",
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
                  child: Divider(
                    color: Constants.primaryColor,
                  ),
                ),
                BuildPaymentMethods(
                  assetImage: "assets/images/zarin.png",
                  title: "زرین پال",
                  description: "پرداخت آنلاین با درگاه زرین پال",
                  onPressed: () {},
                ),
                BuildPaymentMethods(
                  assetImage: "assets/images/nexpay.png",
                  title: "نکست پی",
                  description: "پرداخت آنلاین با درگاه نکست پی",
                  onPressed: () {},
                ),
                const SizedBox(
                  height: 30,
                ),
                const BuildPaymentOptions(
                  icon: Icons.payments,
                  title: "پرداخت آفلاین",
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
                  child: Divider(
                    color: Constants.primaryColor,
                  ),
                ),
                BuildPaymentMethods(
                  assetImage: "assets/images/cod.png",
                  title: "پرداخت در محل",
                  description: "پرداخت درب منزل با کارت خوان",
                  onPressed: () {
                    for (var item in itemsInCart) {
                      orderModel.lineItems?.add(
                        LineItems(
                          quantity: item.quantity?.value,
                          productId: item.id,
                        ),
                      );
                    }
                    CustomerDetailsModel customerDetails =
                        Provider.of<CustomerDetailsProvider>(context,
                                listen: false)
                            .customerDetailsModel!;
                    debugPrint(customerDetails.shipping.toString());
                    Navigator.push(
                      context,
                      PageTransition(
                        child: const CreateOrderPage(),
                        type: PageTransitionType.bottomToTop,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
