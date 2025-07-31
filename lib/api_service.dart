import 'dart:convert'; // Para decodificar o JSON
import 'package:http/http.dart' as http; // Para fazer a requisição HTTP
import 'package:login_screen_app/suggestion_model.dart'; // Para usar nosso modelo

class ApiService {
  // A URL da nossa API
  static const String _url = 'https://empiricus-app.empiricus.com.br/mock/list.json';

  // Método para buscar as sugestões.
  // Ele retorna um Future<List<Suggestion>>, o que significa que ele
  // eventualmente retornará uma lista de objetos Suggestion.
  static Future<List<Suggestion>> fetchSuggestions( ) async {
    try {
      // Faz a requisição GET para a URL
      final response = await http.get(Uri.parse(_url ));

      // Verifica se a requisição foi bem-sucedida (código de status 200)
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data.containsKey('groups') && data['groups'] is List) {
          final List<dynamic> groupsJson = data['groups'];

          return groupsJson.map((json) => Suggestion.fromJson(json)).toList();
        } else {
          // Lança um erro claro se a estrutura não for a esperada
          throw Exception('Chave "groups" não encontrada ou não é uma lista no JSON.');
        }
      } else {
        throw Exception('Falha ao carregar as sugestões (Status Code: ${response.statusCode})');
      }
    } catch (e) {
      // Adiciona o print do erro para facilitar a depuração futura
      print('Erro detalhado: $e');
      throw Exception('Erro na requisição: $e');
    }
  }
    }
