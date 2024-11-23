import 'package:flutter/material.dart';
import 'package:wordpress_app/constants/constants.dart';
import 'package:wordpress_app/pages/profile_page/profile_widgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
              child: const CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 50,
                backgroundImage: AssetImage("assets/images/profile.jpg"),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "ساناز امینی",
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
            const Text(
              "Example@gmail.com",
              style: TextStyle(
                  fontFamily: "nanumGothic",
                  color: Colors.black45,
                  fontSize: 15),
            ),
            const SizedBox(
              height: 30,
            ),
            const CustomRow(text: "پروفایل من", icon: Icons.person),
            const CustomRow(text: "سفارشات", icon: Icons.settings),
            const CustomRow(text: "اطلاع‌رسانی‌ها", icon: Icons.notifications),
            const CustomRow(text: "شبکه‌های اجتماعی", icon: Icons.share),
            const CustomRow(text: "خروج", icon: Icons.logout),
          ],
        ),
      ),
    );
  }
}
