import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordpress_app/constants/constants.dart';
import 'package:wordpress_app/pages/cart_page/cart_page.dart';
import 'package:wordpress_app/pages/catalog_page/catalog_page.dart';
import 'package:wordpress_app/pages/home_page/home_page.dart';
import 'package:wordpress_app/pages/profile_page/profile_page.dart';
import 'package:wordpress_app/provider/cart_provider.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  late int bottomNavIndex;

  List<Widget> pages() => [
        const HomePage(),
        const CatalogPage(),
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
      icon: Icon(Icons.book),
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
    "محصولات",
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
              if (index == 2) {
                Provider.of<CartProvider>(context, listen: false)
                    .initializeData();
                Provider.of<CartProvider>(context, listen: false)
                    .getItemsInCartProvider();
              }
            },
          );
        },
      ),
    );
  }
}
