import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:provider/provider.dart';
import 'package:wordpress_app/constants/constants.dart';
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

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Column(
        children: <Widget>[
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
