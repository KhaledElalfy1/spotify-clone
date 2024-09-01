
import 'dart:developer';

import 'package:client/core/helpers/extentions.dart';
import 'package:client/core/routers/routing.dart';
import 'package:client/core/widgets/custom_button.dart';
import 'package:client/features/auth/data/models/user_sign_in_input_model.dart';
import 'package:client/features/auth/data/repo/auth_remote_repo.dart';
import 'package:client/features/auth/presentation/controller/sign_in_cubit/sign_in_cubit.dart';
import 'package:client/features/auth/presentation/view/widgets/sign_in_form.dart';

import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Sign In.',
              style: AppFonts.bold50White,
            ),
            const SizedBox(height: 30),
            const SignInForm(),
            const SizedBox(height: 20),
            CustomButton(
                onPressed: () async {
                  if (SignInCubit.of(context)
                      .formKey
                      .currentState!
                      .validate()) {
                  final res=await  AuthRemoteRepo().signin(
                      userSignInInputModel: UserSignInInputModel(
                        email: SignInCubit.of(context).emailController.text,
                        password: SignInCubit.of(context).passwordController.text,
                      ),
                    );
                  log( res.toString());
                  }
                },
                text: 'Sign In'),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Don\'t have an account?',
                  style: AppFonts.regular16White,
                ),
                TextButton(
                  onPressed: () {
                    context.pushNamed(Routing.signUp);
                 
                  },
                  child: Text(
                    'Sign Up',
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