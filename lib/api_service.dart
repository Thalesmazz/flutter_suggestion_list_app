import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login_screen_app/suggestion_model.dart';

class ApiService {
  static const String _url =
      'https://empiricus-app.empiricus.com.br/mock/list.json';

  static Future<List<Suggestion>> fetchSuggestions() async {
    try {
      final response = await http.get(Uri.parse(_url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data.containsKey('groups') && data['groups'] is List) {
          final List<dynamic> groupsJson = data['groups'];
          return groupsJson.map((json) => Suggestion.fromJson(json)).toList();
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
