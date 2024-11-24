import 'package:flutter/material.dart';
import 'package:wordpress_app/utils/custom_appbar.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.customAppBarAddress(context, "سفارش‌های من"),
    );
  }
}
