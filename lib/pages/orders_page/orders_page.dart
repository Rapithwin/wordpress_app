import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:wordpress_app/constants/constants.dart';
import 'package:wordpress_app/pages/orders_page/orders_widget.dart';
import 'package:wordpress_app/utils/custom_appbar.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  final NumberFormat numberFormat = NumberFormat.decimalPattern("fa");

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Scaffold(
        appBar: CustomAppBar.customAppBarAddress(
          context,
          "سفارش‌های من",
          bottom: TabBar(
            indicatorColor: Constants.primaryColor,
            overlayColor: WidgetStateColor.transparent,
            labelStyle: textTheme.labelMedium,
            unselectedLabelStyle: textTheme.labelMedium?.copyWith(
              color: Colors.grey[600],
            ),
            tabs: const <Widget>[
              Tab(
                text: "همه",
              ),
              Tab(
                text: "جاری",
              ),
              Tab(
                text: "تحویل شده",
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            BuildOrdersPage(),
            BuildOrdersPage(
              status: "processing",
            ),
            BuildOrdersPage(
              status: "completed",
            ),
          ],
        ),
      ),
    );
  }
}
