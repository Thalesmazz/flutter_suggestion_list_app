import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../data/models/suggestion_model.dart';
import '../presentation/details/pages/details_page.dart';
import '../presentation/home/pages/home_page.dart';
import '../presentation/authentication/pages/login_page.dart';
import '../presentation/home/view_models/home_viewmodel.dart';
import '../presentation/authentication/view_models/login_viewmodel.dart';
import '../presentation/authentication/pages/signup_page.dart';
import '../presentation/authentication/view_models/signup_viewmodel.dart';

class AppRoutes {
  static final GoRouter _router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => ChangeNotifierProvider(
          create: (context) => LoginViewModel(),
          child: const LoginPage(),
        ),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => ChangeNotifierProvider(
          create: (context) => HomeViewModel()..fetchSuggestions(),
          child: const HomePage(),
        ),
      ),
      GoRoute(
        path: '/details',
        builder: (context, state) {
          final suggestion = state.extra as Suggestion;
          return DetailPage(suggestion: suggestion);
        },
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => ChangeNotifierProvider(
          create: (context) => SignUpViewModel(),
          child: const SignUpPage(),
        ),
      ),
    ],
  );

  static GoRouter get router => _router;
}
