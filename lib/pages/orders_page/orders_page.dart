import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:wordpress_app/constants/constants.dart';
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
    final Size size = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: CustomAppBar.customAppBarAddress(context, "سفارش‌های من"),
      body: ListView.builder(
        itemCount: 6,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 15.0,
            ),
            child: Container(
              height: 180,
              width: size.width,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5,
                    spreadRadius: 0.2,
                  )
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0, top: 10.0),
                      child: Row(
                        children: <Widget>[
                          const Icon(
                            Icons.abc,
                            size: 35,
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Text(
                            "درحال بررسی",
                            style: textTheme.titleMedium!.copyWith(
                              color: Constants.blackColor,
                              fontSize: 25,
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Divider(
                        color: Constants.blackColor,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Row(
                            children: [
                              const Icon(Icons.info_outline),
                              const SizedBox(
                                width: 6,
                              ),
                              Text(
                                "شماره سفارش:",
                                style: textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            '۱۲۳۱۲۳۱۲۳',
                            style: textTheme.bodyLarge,
                            textDirection: TextDirection.ltr,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Row(
                            children: [
                              const Icon(Icons.info_outline),
                              const SizedBox(
                                width: 6,
                              ),
                              Text(
                                "تاریخ سفارش:",
                                style: textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            '۱/۲/۱۴۰۳',
                            style: textTheme.bodyLarge,
                            textDirection: TextDirection.ltr,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
