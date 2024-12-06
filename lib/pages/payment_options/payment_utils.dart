import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordpress_app/constants/constants.dart';
import 'package:wordpress_app/pages/root_page/root_page.dart';
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
            Provider.of<CartProvider>(context, listen: false).getTotal(),
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

class BuildPaymentOptions extends StatelessWidget {
  const BuildPaymentOptions({
    super.key,
    required this.icon,
    required this.title,
  });
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: size.width,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(
              icon,
              size: 50,
              color: Constants.primaryColor,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                title,
                style: textTheme.titleSmall,
                textDirection: TextDirection.rtl,
              ),
              const Text(
                "از روش‌های زیر یک مورد را انتخاب کنید.",
                textDirection: TextDirection.rtl,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BuildPaymentMethods extends StatelessWidget {
  const BuildPaymentMethods({
    super.key,
    required this.assetImage,
    required this.title,
    required this.description,
    required this.onPressed,
  });
  final String assetImage;
  final String title;
  final String description;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onPressed,
        child: Container(
          width: size.width,
          height: 70,
          decoration: BoxDecoration(
            color: Constants.primaryColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Image.asset(
                  assetImage,
                  height: 50,
                  width: 50,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    title,
                    style: textTheme.titleSmall?.copyWith(
                      color: Constants.blackColor,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  Text(
                    description,
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(
                      color: Constants.blackColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CreateOrderPage extends StatelessWidget {
  const CreateOrderPage({super.key, required this.isOrderCreated});
  final bool isOrderCreated;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                isOrderCreated ? Icons.check_circle : Icons.error,
                color: isOrderCreated
                    ? Constants.primaryColor.withOpacity(0.8)
                    : const Color.fromARGB(255, 209, 23, 10),
                size: 100,
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                isOrderCreated
                    ? ".سفارش شما با موفقیت ثبت شد"
                    : "سفارش ثبت نشد",
                style: isOrderCreated
                    ? textTheme.titleMedium
                    : textTheme.titleMedium?.copyWith(
                        color: const Color.fromARGB(255, 209, 23, 10),
                      ),
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
      ),
    );
  }
}
