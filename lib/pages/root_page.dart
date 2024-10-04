import 'package:flutter/material.dart';
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

  List<BottomNavigationBarItem> bottomNavBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: "",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart),
      label: "",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: "",
    ),
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
        height: 52,
        child: FittedBox(
          child: FloatingActionButton(
            elevation: 6,
            mini: true,
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      body: IndexedStack(
        index: bottomNavIndex,
        children: pages(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavBarItems,
        elevation: 30,
        currentIndex: bottomNavIndex,
        selectedItemColor: Constants.primaryColor,
        unselectedItemColor: Colors.grey[600],
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        selectedIconTheme: const IconThemeData(size: 30),
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
