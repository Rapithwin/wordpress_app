import 'package:flutter/material.dart';
import 'package:wordpress_app/constants/constants.dart';
import 'package:wordpress_app/utils/custom_appbar.dart';

class VerifyAddressPage extends StatefulWidget {
  const VerifyAddressPage({super.key});

  @override
  State<VerifyAddressPage> createState() => _VerifyAddressPageState();
}

class _VerifyAddressPageState extends State<VerifyAddressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.customAppBarAddress(context),
    );
  }
}
