import 'package:flutter/material.dart';

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
}
