import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordpress_app/constants/constants.dart';
import 'package:wordpress_app/provider/cart_provider.dart';

class PaymentButtomAppBar extends StatelessWidget {
  const PaymentButtomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      width: size.width,
      height: 85.0,
      decoration: BoxDecoration(
        color: Constants.primaryColor.withOpacity(0.2),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Provider.of<CartProvider>(context, listen: true).getTotal(),
            const SizedBox(
              width: 10,
            ),
            Text(
              "مبلغ نهایی",
              style: textTheme.titleLarge?.copyWith(
                color: Constants.blackColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
