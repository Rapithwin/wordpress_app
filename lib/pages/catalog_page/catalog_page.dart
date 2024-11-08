import 'dart:async' show Timer;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:wordpress_app/constants/constants.dart';
import 'package:wordpress_app/pages/catalog_page/sort_class.dart';
import 'package:wordpress_app/pages/product_details.dart';
import 'package:wordpress_app/provider/catalog_provider.dart';
import 'package:wordpress_app/utils/data_status.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  final NumberFormat numberFormat = NumberFormat.decimalPattern("fa");
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  Timer? _debounce;
  int _page = 1;

  final List<SortBy> _sortByOptions = [
    SortBy('popularity', 'محبوبیت', 'asc'),
    SortBy('date', 'قدیمی‌ترین', 'asc'),
    SortBy('date', 'جدیدترین', 'desc'),
    SortBy('price', 'قیمت : از زیاد به کم', 'desc'),
    SortBy('price', 'قیمت : از کم به زیاد', 'asc'),
  ];

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      CatalogProvider productList =
          Provider.of<CatalogProvider>(context, listen: false);
      productList.initializeData();
      productList.setLoadingState(DataStatus.initial);
      productList.fetchProducts(_page);

      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          productList.setLoadingState(DataStatus.loading);
          productList.fetchProducts(++_page);
        }
      });
    });
    _searchController.addListener(_onSearchChanged);
    super.initState();
  }

  void _onSearchChanged() {
    CatalogProvider productList =
        Provider.of<CatalogProvider>(context, listen: false);
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    // When user types a character, it waits for 900ms. If the user types another
    // character before the timer ends, it will reset. If the user doesn't type another
    // character within 900ms, it will search the typed keyword.
    _debounce = Timer(const Duration(milliseconds: 900), () {
      productList.initializeData();
      productList.setLoadingState(DataStatus.initial);
      productList.fetchProducts(_page, searchKeyword: _searchController.text);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    bool isLoadingMore =
        context.watch<CatalogProvider>().getDataStatus() == DataStatus.loading;

    return Scaffold(
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Flexible(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 5.0,
                    ),
                    // Search
                    child: SearchBar(
                      controller: _searchController,
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
                          borderRadius: BorderRadius.circular(20),
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
                        Constants.primaryColor.withOpacity(0.1),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Container(
                  height: 52,
                  width: 52,
                  decoration: BoxDecoration(
                    color: Constants.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: PopupMenuButton(
                    popUpAnimationStyle: AnimationStyle(
                      curve: Curves.easeIn,
                    ),
                    onSelected: (sortBy) {
                      CatalogProvider productList =
                          Provider.of<CatalogProvider>(context, listen: false);
                      productList.initializeData();
                      productList.setSortOrder(sortBy);
                      _page = 1;
                      productList.fetchProducts(_page);
                    },
                    itemBuilder: (context) {
                      return _sortByOptions.map((item) {
                        return PopupMenuItem(
                          value: item,
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              item.text!,
                              style: textTheme.bodyLarge,
                              textDirection: TextDirection.rtl,
                            ),
                          ),
                        );
                      }).toList();
                    },
                  ),
                ),
              ),
            ],
          ),
          Consumer<CatalogProvider>(
            builder: (context, productModel, child) {
              if (productModel.allProducts.isNotEmpty &&
                  productModel.getDataStatus() != DataStatus.initial) {
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: Flexible(
                    child: GridView.count(
                      controller: _scrollController,
                      childAspectRatio: 0.85,
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      children: productModel.allProducts.map(
                        (product) {
                          return GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              PageTransition(
                                  child: ProductDetailsPage(
                                    product: product,
                                  ),
                                  type: PageTransitionType.leftToRight),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                                border:
                                    Border.all(color: Constants.primaryColor),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 15.0,
                                    spreadRadius: 5.0,
                                  ),
                                ],
                              ),
                              margin: const EdgeInsetsDirectional.all(10.0),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      height: 110,
                                      width: 110,
                                      decoration: BoxDecoration(
                                        color: Constants.primaryColor
                                            .withOpacity(0.4),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.network(
                                          product.images![0].src!.replaceAll(
                                              "localhost", "10.0.2.2"),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      product.name!,
                                      maxLines: 2,
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: textTheme.bodyLarge,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "${numberFormat.format(
                                        int.parse(product.price!),
                                      )} تومان",
                                      textAlign: TextAlign.center,
                                      textDirection: TextDirection.rtl,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(color: Constants.primaryColor),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Visibility(
              visible: isLoadingMore,
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: Colors.black, blurRadius: 4)]),
                padding: const EdgeInsets.all(8.0),
                height: 30.0,
                width: 30.0,
                child: const CircularProgressIndicator(
                  color: Constants.primaryColor,
                  strokeWidth: 3.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
