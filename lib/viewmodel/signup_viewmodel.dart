import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';
import '../services/database_service.dart';

enum SignUpState { idle, loading, success, error }

class SignUpViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final DatabaseService _databaseService = DatabaseService();

  SignUpState _state = SignUpState.idle;
  String _errorMessage = '';

  SignUpState get state => _state;
  String get errorMessage => _errorMessage;

  void _setState(SignUpState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<bool> signUp({
    required String fullName,
    required String email,
    required String password,
    required String dateOfBirth,
  }) async {
    _setState(SignUpState.loading);
    try {
      final userCredential = await _authService.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final userId = userCredential.user?.uid;
      if (userId == null) {
        throw Exception('Não foi possível obter o ID do utilizador após a criação.');
      }

      await _databaseService.saveUserData(
        userId: userId,
        userData: {
          'fullName': fullName,
          'email': email,
          'dateOfBirth': dateOfBirth,
        },
      );

      _setState(SignUpState.success);
      return true;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          _errorMessage = 'A palavra-passe é muito fraca.';
          break;
        case 'email-already-in-use':
          _errorMessage = 'Este email já está a ser utilizado.';
          break;
        default:
          _errorMessage = 'Ocorreu um erro de autenticação.';
      }
      _setState(SignUpState.error);
      return false;
    } catch (e) {
      _errorMessage = 'Ocorreu um erro inesperado. Tente novamente.';
      _setState(SignUpState.error);
      return false;
    }
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira o seu nome';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira o seu email';
    }
    if (!value.contains('@') || !value.contains('.')) {
      return 'Formato de email inválido';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira uma palavra-passe';
    }
    if (value.length < 6) {
      return 'A palavra-passe deve ter pelo menos 6 caracteres';
    }
    return null;
  }

  String? validateDob(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, selecione a sua data de nascimento';
    }
    return null;
  }
}

