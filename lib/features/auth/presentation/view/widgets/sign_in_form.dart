import 'package:client/core/widgets/custom_text_form_filed.dart';
import 'package:client/features/auth/presentation/controller/sign_in_cubit/sign_in_cubit.dart';
import 'package:flutter/material.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: SignInCubit.of(context).formKey,
      child: Column(
        children: [
         
          const SizedBox(height: 16),
          CustomTextFormFiled(
            hintText: 'Email',
            controller: SignInCubit.of(context).emailController,
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
            controller: SignInCubit.of(context).passwordController,
            obscureText: true,
          ),
        ],
      ),
    );
  }
}
