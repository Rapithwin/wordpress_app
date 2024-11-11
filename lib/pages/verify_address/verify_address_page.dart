import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordpress_app/constants/constants.dart';
import 'package:wordpress_app/models/woocommerce/customer_details_model.dart';
import 'package:wordpress_app/provider/customer_details_provider.dart';
import 'package:wordpress_app/utils/custom_appbar.dart';
import 'package:wordpress_app/widgets/custom_form_field.dart';

class VerifyAddressPage extends StatefulWidget {
  const VerifyAddressPage({super.key});

  @override
  State<VerifyAddressPage> createState() => _VerifyAddressPageState();
}

class _VerifyAddressPageState extends State<VerifyAddressPage> {
  GlobalKey<FormState> globalKey2 = GlobalKey<FormState>();

  @override
  void initState() {
    Provider.of<CustomerDetailsProvider>(context, listen: false)
        .fetchShippingDetails();
    super.initState();
  }

  Widget _formUI(CustomerDetailsModel? model) {
    final TextEditingController firstName,
        lastName,
        address1,
        country,
        state,
        city,
        phone,
        postcode;
    firstName = TextEditingController(text: model!.firstName);
    lastName = TextEditingController(text: model.lastName);
    address1 = TextEditingController(text: model.shipping!.address1);
    country = TextEditingController(text: model.shipping!.country);
    city = TextEditingController(text: model.shipping!.city);
    state = TextEditingController(text: model.shipping!.state);
    phone = TextEditingController(text: model.shipping!.phone);
    postcode = TextEditingController(text: model.shipping!.postcode);

    return Form(
      key: globalKey2,
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            margin: const EdgeInsets.only(top: 30.0),
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Flexible(
                      child: CustomFormField(
                        labelName: "نام",
                        controller: firstName,
                        textDirection: TextDirection.rtl,
                        inputAction: TextInputAction.done,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: CustomFormField(
                        labelName: "نام خانوادگی",
                        controller: lastName,
                        textDirection: TextDirection.rtl,
                        inputAction: TextInputAction.done,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: CustomFormField(
                        labelName: "استان",
                        controller: state,
                        textDirection: TextDirection.rtl,
                        inputAction: TextInputAction.done,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: CustomFormField(
                        labelName: "کد پستی",
                        controller: postcode,
                        textDirection: TextDirection.rtl,
                        inputAction: TextInputAction.done,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: CustomFormField(
                        labelName: "کشور",
                        controller: country,
                        textDirection: TextDirection.rtl,
                        inputAction: TextInputAction.done,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: CustomFormField(
                        labelName: "شهر",
                        controller: city,
                        textDirection: TextDirection.rtl,
                        inputAction: TextInputAction.done,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Flexible(
                  child: CustomFormField(
                    labelName: "آدرس دقیق پستی",
                    controller: address1,
                    textDirection: TextDirection.rtl,
                    inputAction: TextInputAction.done,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Flexible(
                  child: CustomFormField(
                    labelName: "شماره همراه",
                    controller: phone,
                    textDirection: TextDirection.rtl,
                    inputAction: TextInputAction.done,
                  ),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                Row(
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Constants.primaryColor,
                        elevation: 3,
                        side: BorderSide.none,
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: const Text(
                        "مرحله بعد",
                        style: TextStyle(
                            fontFamily: "Lalezar",
                            fontSize: 25,
                            color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    IconButton(
                      onPressed: () {
                        Provider.of<CustomerDetailsProvider>(context,
                                listen: false)
                            .updateCustomerDetails(
                          CustomerDetailsModel(
                            firstName: firstName.text,
                            lastName: lastName.text,
                            shipping: Ing(
                              address1: address1.text,
                              city: city.text,
                              country: country.text,
                              state: state.text,
                              phone: phone.text,
                              postcode: postcode.text,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.sync),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.customAppBarAddress(context),
      body: Consumer<CustomerDetailsProvider>(
        builder: (context, detailsModel, child) {
          if (detailsModel.customerDetailsModel?.id != null) {
            return _formUI(detailsModel.customerDetailsModel);
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Constants.primaryColor,
            ),
          );
        },
      ),
    );
  }
}
