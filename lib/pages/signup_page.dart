import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
      resizeToAvoidBottomInset: false,
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
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: SizedBox(
            height: size.height * 0.8,
            width: size.width * 0.8,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView(
                children: <Widget>[
                  Center(
                    child: Text(
                      "ثبت نام",
                      style: textTheme.headlineMedium,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      initialValue: customerModel.firstName,
                      onChanged: (value) {
                        customerModel.firstName = value;
                      },
                      textInputAction: TextInputAction.next,
                      cursorColor: Constants.primaryColor,
                      style: textTheme.bodyLarge,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "این فیلد نباید خالی باشد";
                        }
                        return null;
                      },
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
                      initialValue: customerModel.lastName,
                      onChanged: (value) {
                        customerModel.lastName = value;
                      },
                      textInputAction: TextInputAction.next,
                      cursorColor: Constants.primaryColor,
                      style: textTheme.bodyLarge,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "این فیلد نباید خالی باشد";
                        }
                        return null;
                      },
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
                      initialValue: customerModel.username,
                      onChanged: (value) {
                        customerModel.username = value;
                      },
                      textInputAction: TextInputAction.next,
                      cursorColor: Constants.primaryColor,
                      style: textTheme.bodyLarge,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "این فیلد نباید خالی باشد";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: Text(
                          "نام کاربری",
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
                      textInputAction: TextInputAction.next,
                      initialValue: customerModel.email,
                      onChanged: (value) {
                        customerModel.email = value;
                      },
                      cursorColor: Constants.primaryColor,
                      style: textTheme.bodyLarge,
                      textDirection: TextDirection.ltr,
                      keyboardType: TextInputType.emailAddress,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "این فیلد نباید خالی باشد";
                        }
                        return null;
                      },
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
                      textInputAction: TextInputAction.done,
                      initialValue: customerModel.password,
                      onChanged: (value) {
                        customerModel.password = value;
                      },
                      cursorColor: Constants.primaryColor,
                      style: textTheme.bodyLarge,
                      textDirection: TextDirection.ltr,
                      obscureText: true,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "این فیلد نباید خالی باشد";
                        } else if (value.length < 8) {
                          return "رمز عبور باید ۸ کاراکتر یا بیشتر باشد";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: Text(
                          "رمز عبور",
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
                  SizedBox(
                    width: size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          apiService
                              .createCostumer(customerModel)
                              .then((result) {
                            if (result) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Woocommerce App"),
                                    content:
                                        const Text("Registered successfully"),
                                    actions: <Widget>[
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text("OK"))
                                    ],
                                  );
                                },
                              );
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Woocommerce App"),
                                    content:
                                        const Text("Email already registered"),
                                    actions: <Widget>[
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text("OK"))
                                    ],
                                  );
                                },
                              );
                            }
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Constants.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "ٍثبت نام",
                        style: textTheme.titleLarge!.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: size.width,
                    child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          ".حساب کاربری دارید؟ وارد شوید",
                          style: textTheme.bodyMedium,
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
