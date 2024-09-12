import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wordpress_app/constants/constants.dart';
import 'package:wordpress_app/pages/cart_page.dart';
import 'package:wordpress_app/pages/favorites_page.dart';
import 'package:wordpress_app/pages/home_page.dart';
import 'package:wordpress_app/pages/profile_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  late int bottomNavIndex;

  List<Widget> pages() => [
        const HomePage(),
        const FavoritesPage(),
        const CartPage(),
        const ProfilePage(),
      ];

  List<IconData> iconsList = [
    Icons.home,
    Icons.favorite,
    Icons.shopping_cart,
    Icons.person,
  ];

  List<String> appBarTitles = [
    "خانه",
    "علاقه‌مندی‌ها",
    "سبد خرید",
    "پروفایل",
  ];

  @override
  void initState() {
    bottomNavIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Icon(
                Icons.notifications,
                size: 35,
                color: Colors.grey[600],
              ),
              Text(
                appBarTitles[bottomNavIndex],
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        height: 62,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Constants.primaryColor,
            shape: const CircleBorder(),
            child: const Icon(
              Icons.search,
              color: Colors.white,
              size: 25,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: IndexedStack(
        index: bottomNavIndex,
        children: pages(),
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        notchMargin: 10,
        elevation: 30,
        icons: iconsList,
        activeIndex: bottomNavIndex,
        activeColor: Constants.primaryColor,
        splashColor: Constants.primaryColor,
        inactiveColor: Colors.grey[600],
        onTap: (index) {
          setState(
            () {
              bottomNavIndex = index;
            },
          );
        },
      ),
    );
  }
}
