import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordpress_app/constants/constants.dart';
import 'package:wordpress_app/pages/payment_options/payment_utils.dart';
import 'package:wordpress_app/provider/cart_provider.dart';
import 'package:wordpress_app/utils/custom_appbar.dart';

class PaymentOptionsPage extends StatefulWidget {
  const PaymentOptionsPage({super.key});

  @override
  State<PaymentOptionsPage> createState() => _PaymentOptionsPageState();
}

class _PaymentOptionsPageState extends State<PaymentOptionsPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: CustomAppBar.customAppBarAddress(context, "روش پرداخت"),
      bottomNavigationBar: const PaymentButtomAppBar(),
      body: SingleChildScrollView(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Expanded(
              child: Container(
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Constants.primaryColor),
                ),
                child: Column(
                  children: <Widget>[
                    const BuildPaymentOptions(
                      icon: Icons.payment,
                      title: "پرداخت آنلاین",
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
