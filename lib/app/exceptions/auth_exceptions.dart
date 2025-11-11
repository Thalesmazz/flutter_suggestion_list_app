class AuthException implements Exception {
  final String message;
  AuthException(this.message);

  @override
  String toString() => message;
}

class EmailAlreadyInUseAuthException extends AuthException {
  EmailAlreadyInUseAuthException() : super('Este email já está a ser utilizado.');
}

class WrongPasswordAuthException extends AuthException {
  WrongPasswordAuthException() : super('Palavra-passe ou email incorreto.');
}

class UserNotFoundAuthException extends AuthException {
  UserNotFoundAuthException() : super('Palavra-passe ou email incorreto.');
}

class WeakPasswordAuthException extends AuthException {
  WeakPasswordAuthException() : super('A palavra-passe é muito fraca.');
}

class GenericAuthException extends AuthException {
  GenericAuthException() : super('Ocorreu um erro inesperado. Tente novamente.');
}