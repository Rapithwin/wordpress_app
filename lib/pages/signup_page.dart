import 'package:flutter/material.dart';
import 'package:wordpress_app/api/api_service.dart';
import 'package:wordpress_app/constants/constants.dart';
import 'package:wordpress_app/models/woocommerce/costumer_model.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late CustomerModel customerModel;
  late APIService apiService;
  bool isLoading = false;

  @override
  void initState() {
    apiService = APIService();
    customerModel = CustomerModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
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
                child: const Icon(Icons.share)),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 150,
            left: 20,
            right: 20,
            child: SizedBox(
              height: size.height * 0.8,
              width: size.width * 0.8,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          initialValue: customerModel.firstName,
                          onChanged: (value) {
                            customerModel.firstName = value;
                          },
                          cursorColor: Constants.primaryColor,
                          style: textTheme.bodyLarge,
                          decoration: InputDecoration(
                            label: Text(
                              "نام",
                              style: textTheme.titleMedium,
                            ),
                            contentPadding: const EdgeInsets.all(20.0),
                            hintStyle: textTheme.titleLarge!.copyWith(
                              color: Constants.primaryColor,
                              height: 1.5,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Constants.primaryColor,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          initialValue: customerModel.firstName,
                          onChanged: (value) {
                            customerModel.firstName = value;
                          },
                          cursorColor: Constants.primaryColor,
                          style: textTheme.bodyLarge,
                          decoration: InputDecoration(
                            label: Text(
                              "نام خانوادگی",
                              style: textTheme.titleMedium,
                            ),
                            contentPadding: const EdgeInsets.all(20.0),
                            hintStyle: textTheme.titleLarge!.copyWith(
                              color: Constants.primaryColor,
                              height: 1.5,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Constants.primaryColor,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          initialValue: customerModel.firstName,
                          onChanged: (value) {
                            customerModel.firstName = value;
                          },
                          cursorColor: Constants.primaryColor,
                          style: textTheme.bodyLarge,
                          decoration: InputDecoration(
                            label: Text(
                              "ایمیل",
                              style: textTheme.titleMedium,
                            ),
                            contentPadding: const EdgeInsets.all(20.0),
                            hintStyle: textTheme.titleLarge!.copyWith(
                              color: Constants.primaryColor,
                              height: 1.5,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Constants.primaryColor,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          initialValue: customerModel.firstName,
                          onChanged: (value) {
                            customerModel.firstName = value;
                          },
                          cursorColor: Constants.primaryColor,
                          style: textTheme.bodyLarge,
                          decoration: InputDecoration(
                            label: Text(
                              "پسورد",
                              style: textTheme.titleMedium,
                            ),
                            contentPadding: const EdgeInsets.all(20.0),
                            hintStyle: textTheme.titleLarge!.copyWith(
                              color: Constants.primaryColor,
                              height: 1.5,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Constants.primaryColor,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
