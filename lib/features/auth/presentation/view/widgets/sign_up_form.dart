import 'package:client/core/widgets/custom_text_form_filed.dart';
import 'package:flutter/material.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController, required this.formKey,
  });
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    return Form(
      key:formKey,
      child: Column(
        children: [
          CustomTextFormFiled(
            hintText: 'Name',
            controller: nameController,
          ),
          const SizedBox(height: 16),
          CustomTextFormFiled(
            hintText: 'Email',
            controller: emailController,
          ),
          const SizedBox(height: 16),
          CustomTextFormFiled(
            hintText: 'Password',
            validator: (value) {
              if (value!.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
            controller: passwordController,
            obscureText: true,
          ),
        ],
      ),
    );
  }
}
