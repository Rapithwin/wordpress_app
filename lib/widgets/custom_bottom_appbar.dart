import 'package:flutter/material.dart';
import 'package:wordpress_app/constants/constants.dart';

class CustomBottomAppbar extends StatefulWidget {
  const CustomBottomAppbar({super.key});

  @override
  State<CustomBottomAppbar> createState() => _CustomBottomAppbarState();
}

class _CustomBottomAppbarState extends State<CustomBottomAppbar> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    return BottomAppBar(
      color: Constants.primaryColor.withOpacity(0.25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
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
          SizedBox(
            width: size.width * 0.75,
            height: 52,
            child: ElevatedButton(
              onPressed: () {},
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
                style: textTheme.titleMedium!.copyWith(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
