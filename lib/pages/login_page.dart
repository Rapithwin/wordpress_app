import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wordpress_app/api/api_service.dart';
import 'package:wordpress_app/constants/constants.dart';
import 'package:wordpress_app/pages/root_page.dart';
import 'package:wordpress_app/pages/signup_page.dart';
import 'package:wordpress_app/utils/custom_appbar.dart';
import 'package:wordpress_app/utils/custom_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController =
      TextEditingController(text: "amirkh@example.com");
  TextEditingController passwordController =
      TextEditingController(text: "123123123");

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isApiCalled = false;
  APIService apiService = APIService();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar.customAppBarRegister(textTheme, "ورود"),
      body: Center(
        child: SizedBox(
          height: size.height * 0.8,
          width: size.width * 0.8,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              children: [
                Form(
                  key: formKey,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      textDirection: TextDirection.ltr,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
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
                        errorStyle: textTheme.bodyMedium!.copyWith(
                          color: const Color.fromARGB(255, 159, 34, 25),
                          fontSize: 12,
                        ),
                        label: Text(
                          "نام کاربری/ایمیل",
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
                ),
                const SizedBox(
                  height: 30,
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    textDirection: TextDirection.ltr,
                    controller: passwordController,
                    keyboardType: TextInputType.emailAddress,
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
                      errorStyle: textTheme.bodyMedium!.copyWith(
                        color: const Color.fromARGB(255, 159, 34, 25),
                        fontSize: 12,
                      ),
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
                  height: 15,
                ),
                SizedBox(
                  width: size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isApiCalled = true;
                      });
                      apiService
                          .loginCustomer(
                        emailController.text,
                        passwordController.text,
                      )
                          .then(
                        (result) {
                          setState(() {
                            isApiCalled = false;
                          });
                          if (result.token != null) {
                            debugPrint(result.token);
                            Navigator.pushAndRemoveUntil(
                              context,
                              PageTransition(
                                child: const RootPage(),
                                type: PageTransitionType.leftToRight,
                              ),
                              (_) => false,
                            );
                          } else {
                            CustomDialogBox.customDialog(
                              context,
                              textTheme,
                              "Unkown Error",
                              [
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
                        },
                      );
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
                          "ورود",
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
                          child: const SignUpPage(),
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
                      ".حساب کاربری ندارید؟ ثبت‌نام کنید",
                      style: textTheme.bodyMedium,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
