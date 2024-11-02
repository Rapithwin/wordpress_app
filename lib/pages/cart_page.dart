import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:provider/provider.dart';
import 'package:wordpress_app/constants/constants.dart';
import 'package:wordpress_app/models/woocommerce/cart/addtocart_request_model.dart';
import 'package:wordpress_app/provider/cart_provider.dart';
import 'package:wordpress_app/provider/loader_provider.dart';
import 'package:wordpress_app/widgets/add_quantity.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    Future.delayed(Duration.zero).then(
      (value) {
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
    AddCartRequestModel cartReqModel = AddCartRequestModel();
    return Scaffold(
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
                  child: Text(
                    "سبد خرید خالی است",
                    style: textTheme.titleLarge,
                  ),
                )
              : Stack(
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
                                // TODO: Show quantity
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
                                        // TODO: if value < quantity remove item. else add item.
                                        cartReqModel.id = value
                                            .cartItems![index].id
                                            .toString();
                                        cartReqModel.quantity = "1";
                                        if (quantity >
                                            value.cartItems![index].quantity!
                                                .value) {
                                          Provider.of<LoaderProvider>(context,
                                                  listen: false)
                                              .setLoadingStatus(true);
                                          cartProvider.addToCart(cartReqModel,
                                              (val) {
                                            Provider.of<LoaderProvider>(context,
                                                    listen: false)
                                                .setLoadingStatus(false);
                                          });
                                        }
                                      },
                                    ),
                                    TextButton(
                                      onPressed: () {},
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
                                      horizontal: 10.0),
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
                    Positioned(
                      bottom: 0,
                      child: Container(
                        width: size.width,
                        height: 100.0,
                        decoration: BoxDecoration(
                          color: Constants.primaryColor.withOpacity(0.2),
                        ),
                        child: Row(
                          children: <Widget>[
                            Builder(
                              builder: (context) {
                                int totalPrice = 0;
                                for (var item in value.cartItems!) {
                                  totalPrice += item.totals!.total!;
                                }
                                return Text(
                                  "${numberFormat.format(
                                    totalPrice,
                                  )} تومان",
                                  style: textTheme.labelLarge?.copyWith(
                                    fontSize: 25,
                                    color: Constants.blackColor,
                                  ),
                                  textDirection: TextDirection.rtl,
                                );
                              },
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: SizedBox(
                                  width: size.width * 0.75,
                                  height: 52,
                                  child: ElevatedButton(
                                    onPressed: () {},
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
                                      style: textTheme.titleMedium!.copyWith(
                                          color: Colors.white, fontSize: 23),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
