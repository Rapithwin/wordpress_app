import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:wordpress_app/constants/constants.dart';
import 'package:wordpress_app/pages/verify_address/verify_address_page.dart';
import 'package:wordpress_app/provider/cart_provider.dart';
import 'package:wordpress_app/widgets/add_quantity.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then(
      (value) {
        CartProvider cartProvider =
            Provider.of<CartProvider>(context, listen: false);
        cartProvider.initializeData();
        cartProvider.getItemsInCartProvider();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final NumberFormat numberFormat = NumberFormat.decimalPattern("fa");
    final CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    final bool hasPagePushed = Navigator.of(context).canPop();

    return Scaffold(
      appBar: hasPagePushed
          ? AppBar(
              toolbarHeight: 80,
              backgroundColor: Colors.transparent,
              scrolledUnderElevation: 0,
              title: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(
                      Icons.notifications,
                      size: 35,
                      color: Colors.grey[600],
                    ),
                    Text(
                      "سبد خرید",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
            )
          : AppBar(
              toolbarHeight: 0,
            ),
      bottomNavigationBar: Container(
        width: size.width,
        height: 85.0,
        decoration: BoxDecoration(
          color: Constants.primaryColor.withOpacity(0.2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Provider.of<CartProvider>(context, listen: true).getTotal(),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Container(
                  width: size.width * 0.75,
                  constraints: const BoxConstraints(maxWidth: 200),
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          child: const VerifyAddressPage(),
                          type: PageTransitionType.fade,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Constants.primaryColor,
                      elevation: 3,
                      side: BorderSide.none,
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      "ادامه خرید",
                      style: textTheme.titleMedium!
                          .copyWith(color: Colors.white, fontSize: 23),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Consumer<CartProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Constants.primaryColor,
              ),
            );
          }
          return value.cartItems!.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        "assets/images/add-cart.png",
                        height: 225,
                        width: 225,
                      ),
                      Text(
                        "سبد خرید خالی است",
                        style: textTheme.titleLarge,
                      ),
                    ],
                  ),
                )
              : SizedBox(
                  height: size.height,
                  child: Stack(
                    children: <Widget>[
                      ListView.builder(
                        itemCount: value.cartItems!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: size.height / 6,
                              width: size.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                                border: Border.all(
                                  color: Constants.primaryColor,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      AddQuantity(
                                        minNumber: 0,
                                        maxNumber: 20,
                                        iconSize: 17,
                                        value: value
                                            .cartItems![index].quantity!.value!,
                                        valueChanged: (quantity) {
                                          value.updateCartProvider(
                                            value.cartItems![index].itemKey!,
                                            quantity.toString(),
                                          );
                                          Future.delayed(
                                            const Duration(
                                              seconds: 1,
                                            ),
                                          ).then(
                                            (_) {
                                              value.getItemsInCartProvider();
                                            },
                                          );
                                          if (quantity == 0) {
                                            cartProvider.deleteItemProvider(
                                              value.cartItems![index].itemKey!,
                                            );
                                            Future.delayed(
                                                    const Duration(seconds: 1))
                                                .then(
                                              (_) {
                                                cartProvider.initializeData();
                                                cartProvider
                                                    .getItemsInCartProvider();
                                              },
                                            );
                                          }
                                        },
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          cartProvider.deleteItemProvider(
                                            value.cartItems![index].itemKey!,
                                          );
                                          Future.delayed(
                                            const Duration(seconds: 1),
                                          ).then(
                                            (_) {
                                              if (cartProvider
                                                      .cartItems!.length ==
                                                  1) {
                                                cartProvider.initializeData();
                                              }
                                              cartProvider
                                                  .getItemsInCartProvider();
                                            },
                                          );
                                        },
                                        style: ButtonStyle(
                                          overlayColor: WidgetStateProperty.all(
                                            Constants.primaryColor
                                                .withOpacity(0.1),
                                          ),
                                        ),
                                        child: Text(
                                          "حذف",
                                          style: textTheme.labelLarge?.copyWith(
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "${numberFormat.format(value.cartItems![index].totals?.total)} تومان",
                                        textDirection: TextDirection.rtl,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: size.width / 2.3,
                                    child: Text(
                                      value.cartItems![index].title ?? "",
                                      textDirection: TextDirection.rtl,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 7.5,
                                    ),
                                    child: Image.network(
                                      value.cartItems![index].featuredImage!
                                          .replaceAll("localhost", "10.0.2.2"),
                                      height: 80,
                                      width: 80,
                                      scale: 0.5,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
