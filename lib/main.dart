import 'package:client/app.dart';
import 'package:client/features/auth/presentation/controller/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();
  await Hive.initFlutter();
  await Hive.openBox('songs');
  await container.read(authViewModelProvider.notifier).initSharedPreferences();
  await container.read(authViewModelProvider.notifier).getUser();
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const App(),
    ),
  );
}
