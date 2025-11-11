import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:login_screen_app/app/routes.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Login App',
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: AppRoutes.router,
    );
  }
}