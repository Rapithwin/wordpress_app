import 'package:flutter/material.dart';
import 'package:wordpress_app/constants/constants.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key,
    required this.textTheme,
    required this.validator,
    required this.labelName,
    required this.textDirection,
    required this.onChanged,
    required this.inputAction,
    required this.initialValue,
    this.keyboardType,
    this.obscureText,
  });

  final String? initialValue;
  final TextTheme textTheme;
  final String? Function(String?)? validator;
  final String labelName;
  final TextDirection textDirection;
  final TextInputAction inputAction;
  final TextInputType? keyboardType;
  final Function(String?) onChanged;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        textDirection: textDirection,
        initialValue: initialValue,
        obscureText: obscureText ?? false,
        keyboardType: keyboardType,
        onChanged: onChanged,
        textInputAction: inputAction,
        cursorColor: Constants.primaryColor,
        style: textTheme.bodyLarge,
        validator: validator,
        decoration: InputDecoration(
          errorStyle: textTheme.bodyMedium!.copyWith(
            color: const Color.fromARGB(255, 159, 34, 25),
            fontSize: 12,
          ),
          label: Text(
            labelName,
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
    );
  }
}
