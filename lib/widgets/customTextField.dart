import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextInputType textInputType;
  final Widget prefixIcon;
  Widget? suffixIcon;
  final bool isSecured;
  final TextEditingController controller;

  CustomTextField({
      required this.label,
      required this.hint,
      required this.textInputType,
      required this.prefixIcon,
      required this.suffixIcon,
      required this.controller,
      required this.isSecured,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: Colors.black,
      obscureText: isSecured,
      keyboardType: textInputType,
      style: TextStyle(
        color: Colors.black,
      ),
      maxLength: 15,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.black,
        ),
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
        prefixIcon: prefixIcon,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            )
        ),
        border: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.black,
                width: 8
            )
        ),
        suffixIcon: suffixIcon,

      ),
    );
  }
}
