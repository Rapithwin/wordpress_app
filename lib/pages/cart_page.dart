import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordpress_app/constants/constants.dart';
import 'package:wordpress_app/provider/shop_provider.dart';

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
    return Scaffold(
      body: Consumer<ShopProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Constants.primaryColor,
              ),
            );
          }
          return ListView.builder(
            itemCount: value.cartItems!.length,
            itemBuilder: (context, index) {
              return Text(value.cartItems![index].title ?? "");
            },
          );
        },
      ),
    );
  }
}
