import 'package:client/core/routers/app_router.dart';
import 'package:client/core/routers/routing.dart';
import 'package:client/core/utils/app_themes.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: Routing.init,
      theme: appTheme(),
    );
  }
}
