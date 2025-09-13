import '../entities/suggestion_entity.dart';
import '../models/suggestion_model.dart';
import '../services/api_service.dart';

class SuggestionRepository {
  final ApiService _apiService = ApiService();

  Future<List<Suggestion>> fetchSuggestions() async {
    try {
      final List<SuggestionEntity> entities = await _apiService
          .fetchSuggestions();

      final models = entities.map((entity) {
        return Suggestion(
          imageSmallUrl: entity.imageSmall ?? 'https://via.placeholder.com/150',
          title: entity.name ?? 'Título não encontrado',
          shortDescription:
              entity.shortDescription ?? 'Descrição não encontrada',
          imageLargeUrl:
              entity.imageLarge ??
              entity.imageSmall ??
              'https://via.placeholder.com/400',
          fullDescription:
              entity.description ??
              entity.shortDescription ??
              'Descrição completa não encontrada',
        );
      }).toList();

      return models;
    } catch (e) {
      print('Erro no repositório: $e');
      rethrow;
    }
  }
}
