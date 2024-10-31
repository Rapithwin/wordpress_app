import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:provider/provider.dart';
import 'package:wordpress_app/constants/constants.dart';
import 'package:wordpress_app/pages/catalog_page/sort_class.dart';
import 'package:wordpress_app/provider/catalog_provider.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  final NumberFormat numberFormat = NumberFormat.decimalPattern("fa");
  int _page = 1;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      CatalogProvider productList =
          Provider.of<CatalogProvider>(context, listen: false);
      productList.initializeData();
      productList.setLoadingState(DataStatus.initial);
      productList.fetchProducts(_page);
    });
    super.initState();
  }

  final List<SortBy> _sortByOptions = [
    SortBy('popularity', 'محبوبیت', 'asc'),
    SortBy('modified', 'قدیمی ترین', 'asc'),
    SortBy('price', 'قیمت : از زیاد به کم', 'desc'),
    SortBy('price', 'قیمت : از کم به زیاد', 'asc'),
  ];

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;

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
                        horizontal: 10.0, vertical: 5.0),
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
                return Flexible(
                  child: GridView.count(
                    childAspectRatio: 0.85,
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    children: productModel.allProducts.map(
                      (product) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(color: Constants.primaryColor),
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
                                    color:
                                        Constants.primaryColor.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.network(
                                      product.images![0].src!
                                          .replaceAll("localhost", "10.0.2.2"),
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
                        );
                      },
                    ).toList(),
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(color: Constants.primaryColor),
              );
            },
          )
        ],
      ),
    );
  }
}
