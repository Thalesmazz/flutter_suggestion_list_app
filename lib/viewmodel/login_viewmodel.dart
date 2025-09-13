import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

enum LoginState { idle, loading, success, error }

class LoginViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  LoginState _state = LoginState.idle;
  String _errorMessage = '';

  LoginState get state => _state;
  String get errorMessage => _errorMessage;

  void _setState(LoginState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    _setState(LoginState.loading);
    try {
      await _authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _setState(LoginState.success);
      return true;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
        case 'invalid-email':
          _errorMessage = 'Email não encontrado ou inválido.';
          break;
        case 'wrong-password':
        case 'invalid-credential':
          _errorMessage = 'Senha incorreta.';
          break;
        default:
          _errorMessage = 'Ocorreu um erro inesperado. Tente novamente.';
      }
      _setState(LoginState.error);
      return false;
    }
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira seu email';
    }
    if (!value.contains('@') || !value.contains('.')) {
      return 'Email inválido';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'A senha deve ter pelo menos 6 caracteres';
    }
    if (value.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres';
    }
    return null;
  }
}