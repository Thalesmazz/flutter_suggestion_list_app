import 'package:firebase_auth/firebase_auth.dart';
import '../../app/exceptions/auth_exceptions.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential =
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
        case 'invalid-email':
        case 'invalid-credential':
          throw UserNotFoundAuthException();
        case 'wrong-password':
          throw WrongPasswordAuthException();
        default:
          throw GenericAuthException();
      }
    }
  }

  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          throw EmailAlreadyInUseAuthException();
        case 'weak-password':
          throw WeakPasswordAuthException();
        default:
          throw GenericAuthException();
      }
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw GenericAuthException();
    }
  }
}