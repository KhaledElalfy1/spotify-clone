import 'dart:developer';

import 'package:client/core/helpers/extentions.dart';
import 'package:client/core/helpers/functions.dart';
import 'package:client/core/routers/routing.dart';
import 'package:client/core/widgets/custom_button.dart';
import 'package:client/core/widgets/custom_loading.dart';
import 'package:client/features/auth/presentation/controller/auth_viewmodel.dart';
import 'package:client/features/auth/presentation/view/widgets/sign_in_form.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';

class SignInView extends ConsumerStatefulWidget {
  const SignInView({super.key});

  @override
  ConsumerState<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends ConsumerState<SignInView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authViewModelProvider)?.isLoading == true;
    log("the State of Sign In from view: $state");
    ref.listen(authViewModelProvider, (_, next) {
      next?.when(
          data: (data) {
            context.pushNamedAndRemoveUntil(Routing.home,
                predicate: (route) => false);
          },
          error: (error, stackTrace) {
            showSnackBar(context, error.toString());
          },
          loading: () {});
    });
    return Scaffold(
      appBar: AppBar(),
      body: state
          ? const CustomLoading()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sign In.',
                    style: AppFonts.bold50White,
                  ),
                  const SizedBox(height: 30),
                  SignInForm(
                      emailController: emailController,
                      passwordController: passwordController,
                      formKey: formKey),
                  const SizedBox(height: 20),
                  CustomButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          ref.read(authViewModelProvider.notifier).signInUser(
                                email: emailController.text,
                                password: passwordController.text,
                              );
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
