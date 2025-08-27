// Em lib/repositories/suggestion_repository.dart

import 'package:login_screen_app/models/suggestion_model.dart';
import 'package:login_screen_app/services/api_service.dart';

class SuggestionRepository {
  final ApiService _apiService = ApiService();

  Future<List<Suggestion>> fetchSuggestions() {
    return _apiService.fetchSuggestions();
  }
}
