import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:wordpress_app/constants/constants.dart';
import 'package:wordpress_app/provider/shop_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  void initState() {
    Future.delayed(Duration.zero).then(
      (value) {
        ShopProvider productList =
            Provider.of<ShopProvider>(context, listen: false);
        productList.getAllProducts();
        productList.getAllCategories();
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final NumberFormat numberFormat = NumberFormat.decimalPattern("fa");
    final textTheme = Theme.of(context).textTheme;

    return Consumer<ShopProvider>(builder: (context, value, child) {
      if (value.isLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: SearchBar(
                    leading: IconButton(
                      icon: Icon(
                        Icons.search,
                        size: 28,
                        color: Colors.grey[700],
                      ),
                      onPressed: () {},
                    ),
                    trailing: [
                      IconButton(
                        icon: const Icon(
                          Icons.mic,
                          size: 28,
                        ),
                        color: Colors.grey[700],
                        onPressed: () {},
                      )
                    ],
                    shape: WidgetStatePropertyAll<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    hintText: "جستجو...",
                    textStyle: WidgetStatePropertyAll<TextStyle?>(
                      Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.grey[700]),
                    ),
                    elevation: const WidgetStatePropertyAll<double>(0),
                    backgroundColor: WidgetStatePropertyAll<Color>(
                        Constants.primaryColor.withOpacity(0.1)),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                height: 70,
                width: size.width,
                // Showing categories
                child: ListView.builder(
                  reverse: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: value.category!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Text(
                          index == 0
                              ? ""
                              : "|${value.category![index].category}|",
                          style: textTheme.bodyLarge?.copyWith(
                            color: selectedIndex == index
                                ? Constants.primaryColor
                                : Colors.grey[700],
                            fontSize: 19,
                            fontWeight: selectedIndex == index
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Middle section
              // Products
              SizedBox(
                height: size.height * 0.3,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  reverse: true,
                  itemCount: value.product!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 220.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Constants.primaryColor.withOpacity(0.8),
                          ),
                          child: Stack(
                            children: <Widget>[
                              // Name and category
                              Positioned(
                                right: 20,
                                bottom: 50,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    // Categories
                                    Text(
                                      value.product![index].categories![0].name
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: Colors.white70,
                                          ),
                                      textDirection: TextDirection.rtl,
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    // Product name
                                    SizedBox(
                                      width: 180,
                                      child: Text(
                                        value.product![index].name.toString(),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              color: Colors.white,
                                            ),
                                        textDirection: TextDirection.rtl,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Image.network(
                                value.product![index].images![0].src!
                                    .replaceAll("localhost", "10.0.2.2"),
                                height: 140,
                                width: double.maxFinite,
                                scale: 0.5,
                                fit: BoxFit.fill,
                              ),

                              Positioned(
                                left: 22,
                                bottom: 18,
                                child: Container(
                                  height: 25,
                                  width: 110,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Center(
                                      child: Text(
                                        "${numberFormat.format(
                                          int.parse(
                                            value.product![index].price!,
                                          ),
                                        )}تومان",
                                        style: textTheme.bodySmall,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 23, bottom: 8, right: 20),
                child: Text(
                  "گیاهان جدید",
                  style: textTheme.titleLarge?.copyWith(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),

              // New Plants
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: size.height * 0.29,
                child: ListView.builder(
                  itemCount: 10,
                  // itemCount: _plants.length, previous
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Constants.primaryColor.withOpacity(0.1),
                        ),
                        height: 90,
                        width: size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            // Price
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    "assets/images/PriceUnit-green.png",
                                    height: 25,
                                  ),
                                ),
                                Text(
                                  "price",
                                  style: textTheme.labelLarge?.copyWith(
                                      fontSize: 24,
                                      color: Constants.primaryColor),
                                ),
                              ],
                            ),

                            Stack(
                              clipBehavior: Clip.none,
                              children: <Widget>[
                                // Image
                                Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                        Constants.primaryColor.withOpacity(0.8),
                                  ),
                                ),
                                const Positioned(
                                  bottom: 7,
                                  right: -11,
                                  child: Text("img"),
                                ),
                                // Title and category
                                Positioned(
                                  right: 80,
                                  top: 10,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        "Category",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        "name",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                                color: Colors.grey[600],
                                                fontSize: 18),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
