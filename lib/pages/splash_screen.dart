import 'package:flutter/material.dart';
import 'package:wordpress_app/constants/constants.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
            Constants.primaryColor,
            Colors.white,
          ], begin: Alignment.topRight, end: Alignment.bottomRight),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.shopping_cart_checkout_outlined,
              size: 167,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Woocommerce App",
              style: TextStyle(
                fontSize: 30,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
