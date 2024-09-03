import 'dart:developer';

import 'package:client/core/helpers/extentions.dart';
import 'package:client/core/helpers/functions.dart';
import 'package:client/core/routers/routing.dart';
import 'package:client/core/utils/app_colors.dart';
import 'package:client/core/utils/app_fonts.dart';
import 'package:client/core/widgets/custom_button.dart';
import 'package:client/core/widgets/custom_loading.dart';
import 'package:client/features/auth/presentation/controller/auth_viewmodel.dart';
import 'package:client/features/auth/presentation/view/widgets/sign_up_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpView extends ConsumerStatefulWidget {
  const SignUpView({super.key});

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authViewModelProvider)?.isLoading == true;
    log("the state from SignUpView: $state");
    ref.listen(authViewModelProvider, (_, next) {
      next?.when(
        data: (data) {
         showSnackBar(context, 'Sign Up Success');
         

          context.pushReplacementNamed(Routing.signIn);
        },
        error: (error, stackTrace) {
          showSnackBar(context, error.toString());
        
        },
        loading: () {},
      );
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
                    'Sign Up.',
                    style: AppFonts.bold50White,
                  ),
                  const SizedBox(height: 30),
                  SignUpForm(
                    nameController: nameController,
                    emailController: emailController,
                    passwordController: passwordController,
                    formKey: formKey,
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          ref.read(authViewModelProvider.notifier).signUpUser(
                                username: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                              );
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
