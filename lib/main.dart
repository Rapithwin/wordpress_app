import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:wordpress_app/constants/constants.dart';
import 'package:wordpress_app/db/shared_p_db.dart';
import 'package:wordpress_app/pages/cart_page/cart_page.dart';
import 'package:wordpress_app/pages/catalog_page/catalog_page.dart';
import 'package:wordpress_app/pages/home_page/home_page.dart';
import 'package:wordpress_app/pages/login_page/login_page.dart';
import 'package:wordpress_app/pages/payment_options/payment_options.dart';
import 'package:wordpress_app/pages/product_details/product_details.dart';
import 'package:wordpress_app/pages/root_page/root_page.dart';
import 'package:wordpress_app/pages/splash_screen.dart';
import 'package:wordpress_app/pages/verify_address/verify_address_page.dart';
import 'package:wordpress_app/provider/cart_provider.dart';
import 'package:wordpress_app/provider/catalog_provider.dart';
import 'package:wordpress_app/provider/customer_details_provider.dart';
import 'package:wordpress_app/provider/loader_provider.dart';
import 'package:wordpress_app/provider/order_provider.dart';
import 'package:wordpress_app/provider/shop_provider.dart';

void main() async {
  // FIXME: Override HttpClient globaly for self signed certificate issue
  // development only, should not be used in production code
  HttpOverrides.global = MyHttpOverrides();
  await dotenv.load(fileName: ".env");
  runApp(const MainApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ShopProvider(),
          child: const HomePage(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoaderProvider(),
          child: const ProductDetailsPage(),
        ),
        ChangeNotifierProvider(
          create: (context) => CatalogProvider(),
          child: const CatalogPage(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
          child: const CartPage(),
        ),
        ChangeNotifierProvider(
          create: (context) => CustomerDetailsProvider(),
          child: const VerifyAddressPage(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrderProvider(),
          child: const PaymentOptionsPage(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          textTheme: TextTheme(
            headlineLarge: const TextStyle(fontFamily: "Samim"),
            headlineMedium: const TextStyle(
              fontFamily: "Lalezar",
              color: Constants.primaryColor,
              fontSize: 40,
            ),
            titleLarge: TextStyle(
                fontFamily: "Lalezar",
                fontSize: 27,
                fontWeight: FontWeight.normal,
                color: Colors.grey[600]),
            titleMedium: const TextStyle(
              fontFamily: "Lalezar",
              fontSize: 27,
              color: Constants.primaryColor,
            ),
            titleSmall: const TextStyle(
              fontFamily: "Samim",
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Constants.primaryColor,
            ),
            labelLarge: const TextStyle(
              fontFamily: "Lalezar",
              fontSize: 17,
              color: Colors.grey,
            ),
            labelSmall: const TextStyle(
              fontFamily: "Samim",
              fontSize: 16,
              color: Constants.blackColor,
            ),
            labelMedium: const TextStyle(
              fontFamily: "Samim",
              fontSize: 19,
              color: Constants.blackColor,
            ),
            bodyLarge: const TextStyle(fontFamily: "Samim"),
            bodyMedium: const TextStyle(
                fontFamily: "Samim", color: Constants.primaryColor),
            bodySmall: const TextStyle(
              fontFamily: "nanumGothic",
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Constants.primaryColor,
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          future: SharedServices.isLoggedIn(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return snapshot.data! ? const RootPage() : const LoginPage();
            }
            return const SplashScreen();
          },
        ),
      ),
    );
  }
}
