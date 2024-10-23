import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordpress_app/provider/shop_provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    ShopProvider shopProvider =
        Provider.of<ShopProvider>(context, listen: false);

    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {},
      ),
    );
  }
}
