import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:login_screen_app/models/suggestion_model.dart';
import 'package:login_screen_app/view/details_page.dart';
import 'package:login_screen_app/view/home_page.dart';
import 'package:login_screen_app/view/login_page.dart';
import 'package:login_screen_app/viewmodel/home_viewmodel.dart';
import 'package:login_screen_app/viewmodel/login_viewmodel.dart';
import 'package:provider/provider.dart';

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
    ],
  );

  static GoRouter get router => _router;
}
