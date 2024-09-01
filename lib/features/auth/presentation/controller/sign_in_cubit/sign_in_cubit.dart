import 'package:client/features/auth/presentation/controller/sign_in_cubit/sign_in_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());

  static SignInCubit of(context) => BlocProvider.of(context);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Future<void> close() {
    emailController.dispose();

    passwordController.dispose();

    return super.close();
  }
}
