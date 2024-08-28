import 'package:flutter/material.dart';

class AppRouter {
 static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Scaffold());
      // case '/login':
      //   return MaterialPageRoute(builder: (_) => LoginScreen());
      // case '/register':
      //   return MaterialPageRoute(builder: (_) => RegisterScreen());
      // case '/profile':
      //   return MaterialPageRoute(builder: (_) => ProfileScreen());
      default:
        return MaterialPageRoute(builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ));
    }
  }

}