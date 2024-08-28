import 'dart:developer';

import 'package:client/core/utils/app_colors.dart';
import 'package:client/core/utils/app_fonts.dart';
import 'package:client/core/widgets/custom_button.dart';
import 'package:client/features/sign_up/presentation/controller/sign_up_cubit/sign_up_cubit.dart';
import 'package:client/features/sign_up/presentation/view/widgets/sign_up_form.dart';
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
                onPressed: () {
                  if (SignUpCubit.of(context)
                      .formKey
                      .currentState!
                      .validate()) {
                    log('You can now sign up');
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
                  onPressed: () {},
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
