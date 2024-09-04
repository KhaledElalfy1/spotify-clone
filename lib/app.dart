import 'package:client/core/providers/current_user_notifier.dart';
import 'package:client/core/routers/app_router.dart';
import 'package:client/core/routers/routing.dart';
import 'package:client/core/utils/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  Widget build(BuildContext context) {
    final currentUSer = ref.watch(currentUserNotifierProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: currentUSer == null ? Routing.signUp : Routing.home,
      theme: AppThemes.darkThemeMode,
    );
  }
}
