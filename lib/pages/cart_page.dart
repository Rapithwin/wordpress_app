import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordpress_app/constants/constants.dart';
import 'package:wordpress_app/provider/shop_provider.dart';
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
        ShopProvider shopProvider =
            Provider.of<ShopProvider>(context, listen: false);
        shopProvider.getItemsInCartProvider();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Constants.primaryColor.withOpacity(0.25),
        child: Row(
          children: <Widget>[
            Expanded(
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
                    style: textTheme.titleMedium!
                        .copyWith(color: Colors.white, fontSize: 23),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Consumer<ShopProvider>(
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
              : ListView.builder(
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
                                  iconSize: 5,
                                  value: 0,
                                  valueChanged: (d) {},
                                ),
                                TextButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                    overlayColor: WidgetStateProperty.all(
                                      Constants.primaryColor.withOpacity(0.1),
                                    ),
                                  ),
                                  child: Text(
                                    "حذف",
                                    style: textTheme.labelLarge?.copyWith(
                                      color: Colors.red,
                                    ),
                                  ),
                                )
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
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
                );
        },
      ),
    );
  }
}
