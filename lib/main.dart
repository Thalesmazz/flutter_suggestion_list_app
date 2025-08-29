import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:login_screen_app/view/login_page.dart';
import 'package:login_screen_app/viewmodel/login_viewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/login',
      routes: {
        '/login': (context) => ChangeNotifierProvider(
          create: (context) => LoginViewModel(),
          child: const LoginPage(),
        ),
      },
    );
  }
}
