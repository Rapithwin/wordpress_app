import 'package:flutter/material.dart';
import 'package:wordpress_app/api/api_service.dart';
import 'package:wordpress_app/constants/constants.dart';
import 'package:wordpress_app/models/woocommerce/costumer_model.dart';
import 'package:wordpress_app/pages/login_page.dart';
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
        title: Center(
          child: Text(
            "ثبت نام",
            style: textTheme.headlineMedium,
          ),
        ),
        leadingWidth: 80,
        toolbarHeight: 80,
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
                  const SizedBox(
                    height: 20,
                  ),
                  CustomFormField(
                    labelName: "نام",
                    initialValue: customerModel.firstName,
                    textTheme: textTheme,
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
                    labelName: "نام خانوادگی",
                    initialValue: customerModel.lastName,
                    textTheme: textTheme,
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
                    labelName: "ایمیل",
                    keyboardType: TextInputType.emailAddress,
                    initialValue: customerModel.email,
                    textTheme: textTheme,
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
                    labelName: "رمز عبور",
                    keyboardType: TextInputType.visiblePassword,
                    initialValue: customerModel.password,
                    obscureText: true,
                    textTheme: textTheme,
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
                    labelName: "نام کاربری",
                    initialValue: customerModel.username,
                    textTheme: textTheme,
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
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Woocommerce App"),
                                    content: const Text(
                                      "ثبت‌نام با موفقیت انجام شد",
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text("OK"),
                                      )
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
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text("OK"),
                                      )
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
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



// class CustomFormField extends StatelessWidget {
//   const CustomFormField({
//     super.key,
//     required this.customerModel,
//     required this.textTheme,
//   });

//   final CustomerModel customerModel;
//   final TextTheme textTheme;

//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: TextFormField(
//         initialValue: customerModel.firstName,
//         onChanged: (value) {
//           customerModel.firstName = value;
//         },
//         textInputAction: TextInputAction.next,
//         cursorColor: Constants.primaryColor,
//         style: textTheme.bodyLarge,
//         validator: (String? value) {
//           if (value!.isEmpty) {
//             return "این فیلد نباید خالی باشد";
//           }
//           return null;
//         },
//         decoration: InputDecoration(
//           errorStyle: textTheme.bodyMedium!.copyWith(
//             color: const Color.fromARGB(255, 159, 34, 25),
//             fontSize: 12,
//           ),
//           label: Text(
//             "نام",
//             style: textTheme.titleMedium,
//           ),
//           contentPadding: const EdgeInsets.all(20.0),
//           hintStyle: textTheme.titleLarge!.copyWith(
//             color: Constants.primaryColor,
//             height: 1.5,
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: const BorderSide(
//               color: Constants.primaryColor,
//               width: 1.0,
//             ),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//       ),
//     );
//   }
// }
