import 'package:flutter/material.dart';

enum LoginState { idle, loading, success, error }

class LoginViewModel extends ChangeNotifier {
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

    await Future.delayed(const Duration(seconds: 2));

    if (email == 'thales@empiricus.com.br' && password == '123456') {
      _setState(LoginState.success);
      return true;
    } else {
      _errorMessage = 'Email ou senha inválidos.';
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
      return 'Por favor, insira sua senha';
    }
    if (value.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres';
    }
    return null;
  }
}
