import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wordpress_app/constants/constants.dart';
import 'package:wordpress_app/pages/signup_page.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
          headlineLarge: const TextStyle(fontFamily: "Samim"),
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
          bodyLarge: const TextStyle(fontFamily: "Samim"),
          bodyMedium: const TextStyle(fontFamily: "Samim"),
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
          child: SignUpPage(),
        ),
      ),
    );
  }
}
