import 'package:flutter/material.dart';
import 'package:wordpress_app/constants/constants.dart';
import 'package:wordpress_app/pages/root_page/root_page.dart';

class CreateOrderPage extends StatelessWidget {
  const CreateOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/images/successful_payment.png"),
            Text(
              ".سفارش شما ثبت شد",
              style: textTheme.titleMedium,
            ),
            Text(
              "کد پیگیری: ۲۲۲۲۲",
              style: textTheme.titleMedium,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RootPage(),
                  ),
                  (_) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Constants.primaryColor,
                elevation: 3,
                side: BorderSide.none,
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text(
                "بازگشت به صفحه اصلی",
                style: TextStyle(
                  fontFamily: "Lalezar",
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
