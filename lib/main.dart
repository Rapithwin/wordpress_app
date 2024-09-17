import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wordpress_app/constants/constants.dart';
import 'package:wordpress_app/pages/login_page.dart';
import 'package:wordpress_app/pages/root_page.dart';

void main() async {
  // Override HttpClient globaly for self signed certificate issue
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
    return MaterialApp(
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
      home: const Scaffold(
        body: Center(
          child: LoginPage(),
        ),
      ),
    );
  }
}
