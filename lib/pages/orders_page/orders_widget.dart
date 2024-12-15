import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:provider/provider.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:wordpress_app/constants/constants.dart';
import 'package:wordpress_app/provider/order_provider.dart';
import 'package:wordpress_app/utils/extention.dart';

class BuildOrdersPage extends StatefulWidget {
  const BuildOrdersPage({super.key, this.status});
  final String? status;

  @override
  State<BuildOrdersPage> createState() => _BuildOrdersPageState();
}

class _BuildOrdersPageState extends State<BuildOrdersPage> {
  final NumberFormat numberFormat = NumberFormat.decimalPattern("fa");

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      OrderProvider orderProvider =
          Provider.of<OrderProvider>(context, listen: false);
      orderProvider.getAllOrdersProvider(widget.status);
    });
    super.initState();
  }

  String myDateFormat(Jalali date) {
    final f = date.formatter;

    return "${f.yyyy.farsiNumber}/${f.mm.farsiNumber}/${f.dd.farsiNumber}";
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Consumer<OrderProvider>(
        builder: (context, order, child) {
          return order.isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Constants.primaryColor,
                  ),
                )
              : order.ordersList!.isEmpty
                  ? Center(
                      child: Text(
                        "هنوز سفارشی ثبت نکرده‌اید",
                        style: textTheme.titleLarge,
                      ),
                    )
                  : ListView.builder(
                      itemCount: order.ordersList?.length,
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
                                    padding: const EdgeInsets.only(
                                        right: 10.0, top: 10.0),
                                    child: Row(
                                      children: <Widget>[
                                        order.ordersList![index].status! ==
                                                "completed"
                                            ? const Icon(
                                                Icons.check_circle,
                                                size: 35,
                                                color: Constants.primaryColor,
                                              )
                                            : const Icon(
                                                Icons.pending,
                                                size: 35,
                                                color: Color.fromARGB(
                                                    255, 255, 170, 59),
                                              ),
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        Text(
                                          order.ordersList![index].status! ==
                                                  "completed"
                                              ? "تحویل شده"
                                              : "جاری",
                                          style:
                                              textTheme.titleMedium!.copyWith(
                                            color: Constants.blackColor,
                                            fontSize: 25,
                                          ),
                                          textDirection: TextDirection.rtl,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15.0),
                                    child: Divider(
                                      color: Constants.blackColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
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
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: Text(
                                          numberFormat.format(
                                              order.ordersList![index].orderId),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
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
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: Text(
                                          myDateFormat(order
                                              .ordersList![index].orderDate!
                                              .toJalali()),
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
                    );
        },
      ),
    );
  }
}
