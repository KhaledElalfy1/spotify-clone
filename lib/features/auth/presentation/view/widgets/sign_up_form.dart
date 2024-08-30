import 'package:client/core/widgets/custom_text_form_filed.dart';
import 'package:client/features/auth/presentation/controller/sign_up_cubit/sign_up_cubit.dart';
import 'package:flutter/material.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: SignUpCubit.of(context).formKey,
      child: Column(
        children: [
          CustomTextFormFiled(
            hintText: 'Name',
            controller: SignUpCubit.of(context).nameController,
          ),
          const SizedBox(height: 16),
          CustomTextFormFiled(
            hintText: 'Email',
            controller: SignUpCubit.of(context).emailController,
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
            controller: SignUpCubit.of(context).passwordController,
            obscureText: true,
          ),
        ],
      ),
    );
  }
}
