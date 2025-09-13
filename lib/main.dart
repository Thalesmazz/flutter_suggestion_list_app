import 'package:flutter/material.dart';
import 'package:login_screen_app/app_routes.dart';

void main() {
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
