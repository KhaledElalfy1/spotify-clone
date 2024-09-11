

import 'package:flutter/material.dart';

class CustomTextFormFiled extends StatelessWidget {
  const CustomTextFormFiled({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.validator,
    this.readOnly = false,
    this.onTap,
  
  });
  final String hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final bool readOnly;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;

  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      
      readOnly: readOnly,
     
      validator: validator ??
          (value) {
            if (value!.trim().isEmpty) {
              return 'This field is required';
            }
            return null;
          },
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}
