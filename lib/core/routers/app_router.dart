import 'package:client/features/sign_up/presentation/controller/sign_up_cubit/sign_up_cubit.dart';
import 'package:client/features/sign_up/presentation/view/sign_up_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SignUpCubit(),
            child: const SignUpView(),
          ),
        );
      // case '/login':
      //   return MaterialPageRoute(builder: (_) => LoginScreen());
      // case '/register':
      //   return MaterialPageRoute(builder: (_) => RegisterScreen());
      // case '/profile':
      //   return MaterialPageRoute(builder: (_) => ProfileScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
