import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordpress_app/constants/constants.dart';
import 'package:wordpress_app/models/woocommerce/cart/addtocart_request_model.dart';
import 'package:wordpress_app/models/woocommerce/products_model.dart';
import 'package:wordpress_app/provider/cart_provider.dart';
import 'package:wordpress_app/provider/loader_provider.dart';
import 'package:wordpress_app/widgets/add_quantity.dart';

class CustomBottomAppbar extends StatefulWidget {
  const CustomBottomAppbar({super.key, required this.product});
  final ProductModel product;

  @override
  State<CustomBottomAppbar> createState() => _CustomBottomAppbarState();
}

class _CustomBottomAppbarState extends State<CustomBottomAppbar> {
  int quantity = 0;
  AddCartRequestModel cartReqModel = AddCartRequestModel();

  late String response;

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);

    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    return BottomAppBar(
      color: Constants.primaryColor.withOpacity(0.25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Badge.count(
            alignment: Alignment.topRight,
            largeSize: 21,
            count: cartProvider.cartItems!.length,
            child: Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Constants.primaryColor.withOpacity(0.6),
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.shopping_cart,
                  size: 26,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          AddQuantity(
              minNumber: 0,
              maxNumber: 20,
              iconSize: 20,
              value: quantity,
              valueChanged: (value) {
                cartReqModel.quantity = value.toString();
              }),
          Expanded(
            child: SizedBox(
              width: size.width * 0.75,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  Provider.of<LoaderProvider>(context, listen: false)
                      .setLoadingStatus(true);

                  cartReqModel.id = widget.product.id.toString();
                  cartProvider.addToCart(
                    cartReqModel,
                    (val) {
                      Provider.of<LoaderProvider>(context, listen: false)
                          .setLoadingStatus(false);
                    },
                  );
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text("سبد خرید"),
                      content: const Text(""),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Constants.primaryColor,
                  elevation: 3,
                  side: BorderSide.none,
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  "افزودن به سبد خرید",
                  style: textTheme.titleMedium!
                      .copyWith(color: Colors.white, fontSize: 23),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
