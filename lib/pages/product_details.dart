import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:readmore/readmore.dart';
import 'package:wordpress_app/models/woocommerce/products_model.dart';
import 'package:wordpress_app/utils/custom_appbar.dart';
import 'package:wordpress_app/utils/extention.dart';
import 'package:wordpress_app/widgets/custom_bottom_appbar.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key, this.product});
  final ProductModel? product;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    final NumberFormat numberFormat = NumberFormat.decimalPattern("fa");
    return Scaffold(
      appBar: CustomAppBar.customAppBarDetail(context),
      bottomNavigationBar: const CustomBottomAppbar(),
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          child: Column(
            children: <Widget>[
              // Image
              SizedBox(
                width: size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.network(
                      widget.product!.images![0].src!.replaceAll(
                        "localhost",
                        "10.0.2.2",
                      ),
                      height: 240,
                      width: size.width,
                      scale: 0.5,
                      fit: BoxFit.contain,
                    ),
                    // title
                    Text(
                      widget.product!.name ?? "null",
                      textDirection: TextDirection.rtl,
                      style: textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              //description
              SizedBox(
                width: size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ReadMoreText(
                        widget.product!.description!.removeHtml,
                        trimLines: 2,
                        trimCollapsedText: "بیشتر",
                        trimExpandedText: "بستن",
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.justify,
                        moreStyle: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        lessStyle: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        "${numberFormat.format(
                          int.parse(
                            widget.product!.price!,
                          ),
                        )}  تومان",
                        style: textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
