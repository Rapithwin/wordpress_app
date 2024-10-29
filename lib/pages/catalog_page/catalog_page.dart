import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:provider/provider.dart';
import 'package:wordpress_app/provider/catalog_provider.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  final NumberFormat numberFormat = NumberFormat.decimalPattern("fa");
  int _page = 0;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      var productList = Provider.of<CatalogProvider>(context, listen: false);
      productList.initializeData();
      productList.setLoadingState(DataStatus.initial);
      productList.fetchProducts(_page);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Consumer<CatalogProvider>(
            builder: (context, productModel, child) {
              if (productModel.allProducts.isNotEmpty &&
                  productModel.getDataStatus() != DataStatus.initial) {
                return Flexible(
                  child: GridView.count(crossAxisCount: 2),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          )
        ],
      ),
    );
  }
}
