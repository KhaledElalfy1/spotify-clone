import 'package:client/core/routers/routing.dart';
import 'package:client/features/auth/presentation/controller/sign_in_cubit/sign_in_cubit.dart';
import 'package:client/features/auth/presentation/view/sign_in_view.dart';
import 'package:client/features/auth/presentation/controller/sign_up_cubit/sign_up_cubit.dart';
import 'package:client/features/auth/presentation/view/sign_up_view.dart';
import 'package:client/features/home/view/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
       case Routing.signIn:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SignInCubit(),
            child: const SignInView(),
          ),
        );
        
      case Routing.signUp:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SignUpCubit(),
            child: const SignUpView(),
          ),
        );
     
      // case '/register':
      //   return MaterialPageRoute(builder: (_) => RegisterScreen());
      // case '/profile':
      //   return MaterialPageRoute(builder: (_) => ProfileScreen());

      case Routing.home:
        return MaterialPageRoute(builder: (_) => const HomePage());
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
