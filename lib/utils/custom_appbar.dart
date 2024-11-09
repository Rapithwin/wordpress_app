import 'package:flutter/material.dart';
import 'package:wordpress_app/constants/constants.dart';

class CustomAppBar {
  static AppBar customAppBarRegister(TextTheme textTheme, String title) {
    return AppBar(
      title: Center(
        child: Text(
          title,
          style: textTheme.headlineMedium,
        ),
      ),
      automaticallyImplyLeading: false,
      leadingWidth: 80,
      toolbarHeight: 80,
    );
  }

  static AppBar customAppBarAddress(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      leadingWidth: 80,
      backgroundColor: Colors.transparent,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      leading: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          decoration: BoxDecoration(
            color: Constants.primaryColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(50),
          ),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.close,
              color: Constants.primaryColor,
            ),
          ),
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 20),
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            "تکمیل اطلاعات",
            style: Theme.of(context).textTheme.titleLarge,
            textDirection: TextDirection.rtl,
          ),
        ),
      ),
    );
  }

  static AppBar customAppBarDetail(BuildContext context) {
    return AppBar(
      leadingWidth: 80,
      toolbarHeight: 80,
      leading: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          decoration: BoxDecoration(
            color: Constants.primaryColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(50),
          ),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.close,
              color: Constants.primaryColor,
            ),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Constants.primaryColor.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.favorite,
              color: Constants.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
