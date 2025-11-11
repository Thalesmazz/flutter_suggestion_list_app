import 'package:firebase_database/firebase_database.dart';

class DatabaseService {
  final FirebaseDatabase _db = FirebaseDatabase.instance;

  Future<void> saveUserData({
    required String userId,
    required Map<String, dynamic> userData,
  }) async {
    try {
      final userRef = _db.ref('users/$userId');
      await userRef.set(userData);
    } catch (e) {
      print('Erro ao guardar os dados do utilizador: $e');
      rethrow;
    }
  }
}