import 'package:flutter/material.dart';

AppBar customAppBar(TextTheme textTheme, String title) {
  return AppBar(
    title: Center(
      child: Text(
        title,
        style: textTheme.headlineMedium,
      ),
    ),
    leadingWidth: 80,
    toolbarHeight: 80,
  );
}
