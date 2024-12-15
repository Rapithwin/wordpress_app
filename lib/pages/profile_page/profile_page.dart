import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:wordpress_app/constants/constants.dart';
import 'package:wordpress_app/db/shared_p_db.dart';
import 'package:wordpress_app/pages/login_page/login_page.dart';
import 'package:wordpress_app/pages/orders_page/orders_page.dart';
import 'package:wordpress_app/pages/profile_page/profile_widgets.dart';
import 'package:wordpress_app/provider/customer_details_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((val) {
      CustomerDetailsProvider customerDetails =
          Provider.of<CustomerDetailsProvider>(context, listen: false);
      customerDetails.fetchShippingDetails();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Constants.primaryColor.withOpacity(0.5),
                  width: 5,
                ),
              ),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 50,
                backgroundImage: NetworkImage(
                  context
                      .watch<CustomerDetailsProvider>()
                      .customerDetailsModel!
                      .avatarUrl
                      .toString()
                      .replaceAll(
                        "localhost",
                        "10.0.2.2",
                      ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${context.watch<CustomerDetailsProvider>().customerDetailsModel!.firstName} ${context.watch<CustomerDetailsProvider>().customerDetailsModel!.lastName}",
                  style: textTheme.bodyLarge?.copyWith(
                    color: Colors.black54,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Image.asset(
                  "assets/images/verified.png",
                  height: 23,
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              context
                      .watch<CustomerDetailsProvider>()
                      .customerDetailsModel!
                      .email ??
                  "ایمیل ثبت نشده",
              style: const TextStyle(
                fontFamily: "nanumGothic",
                color: Colors.black45,
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            CustomRow(text: "پروفایل من", icon: Icons.person, onPressed: () {}),
            CustomRow(
              text: "سفارش‌ها",
              icon: Icons.settings,
              onPressed: () => Navigator.push(
                context,
                PageTransition(
                  child: const OrdersPage(),
                  type: PageTransitionType.bottomToTop,
                ),
              ),
            ),
            CustomRow(
                text: "اطلاع‌رسانی‌ها",
                icon: Icons.notifications,
                onPressed: () {}),
            CustomRow(
                text: "شبکه‌های اجتماعی", icon: Icons.share, onPressed: () {}),
            CustomRow(
              text: "خروج",
              icon: Icons.logout,
              onPressed: () {
                SharedServices.logOut().then(
                  (_) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      PageTransition(
                        child: const LoginPage(),
                        type: PageTransitionType.fade,
                      ),
                      (_) => false,
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
