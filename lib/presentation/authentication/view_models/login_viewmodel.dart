import 'package:flutter/foundation.dart';
import '../../../app/exceptions/auth_exceptions.dart';
import '../../../data/repositories/auth_repository.dart';

enum LoginState { idle, loading, success, error }

class LoginViewModel extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();

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
      await _authRepository.signIn(
        email: email,
        password: password,
      );
      _setState(LoginState.success);
      return true;
    } on AuthException catch (e) {
      _errorMessage = e.message;
      _setState(LoginState.error);
      return false;
    } catch (e) {
      _errorMessage = 'Ocorreu um erro inesperado. Tente novamente.';
      _setState(LoginState.error);
      return false;
    }
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira o seu email';
    }
    if (!value.contains('@') || !value.contains('.')) {
      return 'Email inválido';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira a sua senha';
    }
    if (value.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres';
    }
    return null;
  }
}