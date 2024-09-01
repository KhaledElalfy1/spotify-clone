import 'dart:developer';

import 'package:client/core/helpers/extentions.dart';
import 'package:client/core/utils/app_colors.dart';
import 'package:client/core/utils/app_fonts.dart';
import 'package:client/core/widgets/custom_button.dart';
import 'package:client/features/auth/data/models/user_sign_up_input_model.dart';
import 'package:client/features/auth/data/repo/auth_remote_repo.dart';
import 'package:client/features/auth/presentation/controller/sign_up_cubit/sign_up_cubit.dart';
import 'package:client/features/auth/presentation/view/widgets/sign_up_form.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Sign Up.',
              style: AppFonts.bold50White,
            ),
            const SizedBox(height: 30),
            const SignUpForm(),
            const SizedBox(height: 20),
            CustomButton(
                onPressed: () async {
                  if (SignUpCubit.of(context)
                      .formKey
                      .currentState!
                      .validate()) {
                    final res = await AuthRemoteRepo().signup(
                      userSignUpInputModel: UserSignUpInputModel(
                        name: SignUpCubit.of(context).nameController.text,
                        email: SignUpCubit.of(context).emailController.text,
                        password:
                            SignUpCubit.of(context).passwordController.text,
                      ),
                    );
                    log(res.toString());
                  }
                },
                text: 'Sign Up'),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an account?',
                  style: AppFonts.regular16White,
                ),
                TextButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: Text(
                    'Sign In',
                    style: AppFonts.regular16White.copyWith(
                      color: AppColors.gradient2,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
