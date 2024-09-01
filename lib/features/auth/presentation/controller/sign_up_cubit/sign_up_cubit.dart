import 'package:client/features/auth/presentation/controller/sign_up_cubit/sign_up_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());
  static SignUpCubit of(context) => BlocProvider.of(context);
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();


  
  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    return super.close();
  }
}
