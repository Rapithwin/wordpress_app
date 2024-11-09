import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wordpress_app/api/api_service.dart';
import 'package:wordpress_app/constants/constants.dart';
import 'package:wordpress_app/models/woocommerce/costumer_model.dart';
import 'package:wordpress_app/pages/login_page/login_page.dart';
import 'package:wordpress_app/utils/custom_appbar.dart';
import 'package:wordpress_app/utils/custom_dialog.dart';
import 'package:wordpress_app/utils/extention.dart';
import 'package:wordpress_app/widgets/custom_form_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late CustomerModel customerModel;
  late APIService apiService;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isApiCalled = false;

  late TextEditingController firstName =
      TextEditingController(text: customerModel.firstName);
  late TextEditingController lastName =
      TextEditingController(text: customerModel.lastName);
  late TextEditingController email =
      TextEditingController(text: customerModel.email);
  late TextEditingController password =
      TextEditingController(text: customerModel.password);
  late TextEditingController username =
      TextEditingController(text: customerModel.username);

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
      appBar: CustomAppBar.customAppBarRegister(textTheme, "ثبت نام"),
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
                  const SizedBox(
                    height: 20,
                  ),
                  CustomFormField(
                    controller: firstName,
                    labelName: "نام",
                    initialValue: customerModel.firstName,
                    textDirection: TextDirection.rtl,
                    inputAction: TextInputAction.next,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "این فیلد نباید خالی باشد";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      customerModel.firstName = value;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomFormField(
                    controller: lastName,
                    labelName: "نام خانوادگی",
                    initialValue: customerModel.lastName,
                    textDirection: TextDirection.rtl,
                    inputAction: TextInputAction.next,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "این فیلد نباید خالی باشد";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      customerModel.lastName = value;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomFormField(
                    controller: email,
                    labelName: "ایمیل",
                    keyboardType: TextInputType.emailAddress,
                    initialValue: customerModel.email,
                    textDirection: TextDirection.ltr,
                    inputAction: TextInputAction.next,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "این فیلد نباید خالی باشد";
                      }
                      if (!value.isEmailValid) {
                        return "ایمیل نامعتبر";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      customerModel.email = value;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomFormField(
                    controller: password,
                    labelName: "رمز عبور",
                    keyboardType: TextInputType.visiblePassword,
                    initialValue: customerModel.password,
                    obscureText: true,
                    textDirection: TextDirection.ltr,
                    inputAction: TextInputAction.next,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "این فیلد نباید خالی باشد";
                      }
                      if (value.length < 8) {
                        return "رمز عبور باید هشت کاراکتر یا بیشتر باشد";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      customerModel.password = value;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomFormField(
                    controller: username,
                    labelName: "نام کاربری",
                    initialValue: customerModel.username,
                    textDirection: TextDirection.ltr,
                    inputAction: TextInputAction.done,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "این فیلد نباید خالی باشد";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      customerModel.username = value;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            isApiCalled = true;
                          });
                          apiService
                              .createCostumer(customerModel)
                              .then((result) {
                            setState(() {
                              isApiCalled = false;
                            });
                            if (result) {
                              CustomDialogBox.customDialog(
                                context,
                                textTheme,
                                "ثبت‌نام با موفقیت انجام شد",
                                <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text(
                                      "بستن",
                                      style: textTheme.labelSmall,
                                    ),
                                  )
                                ],
                              );
                            } else {
                              CustomDialogBox.customDialog(
                                context,
                                textTheme,
                                "ثبت‌نام انجام نشد.",
                                <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text(
                                      "بستن",
                                      style: textTheme.labelSmall,
                                    ),
                                  )
                                ],
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          isApiCalled
                              ? const SizedBox(
                                  height: 17,
                                  width: 17,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(""),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "ٍثبت نام",
                            style: textTheme.titleLarge!.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: size.width,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          PageTransition(
                            child: const LoginPage(),
                            type: PageTransitionType.fade,
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        ".حساب کاربری دارید؟ وارد شوید",
                        style: textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
