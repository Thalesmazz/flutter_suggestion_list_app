import 'dart:convert';
import 'package:http/http.dart' as http;
import '../entities/suggestion_entity.dart';
import '../config.dart';

class ApiService {
  final String _url = AppConfig.baseUrl;

  Future<List<SuggestionEntity>> fetchSuggestions() async {
    try {
      final response = await http.get(Uri.parse(_url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data.containsKey('groups') && data['groups'] is List) {
          final List<dynamic> groupsJson = data['groups'];
          return groupsJson
              .map((json) => SuggestionEntity.fromJson(json))
              .toList();
        } else {
          throw Exception(
            'Chave "groups" não encontrada ou não é uma lista no JSON.',
          );
        }
      } else {
        throw Exception(
          'Falha ao carregar as sugestões (Status Code: ${response.statusCode})',
        );
      }
    } catch (e) {
      print('Erro detalhado: $e');
      throw Exception('Erro na requisição: $e');
    }
  }
}
