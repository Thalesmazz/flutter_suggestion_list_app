import 'package:flutter/material.dart';
import 'package:login_screen_app/api_service.dart';
import 'package:login_screen_app/suggestion_model.dart';
import 'package:login_screen_app/details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Suggestion>> _suggestionsFuture;

  @override
  void initState() {
    super.initState();
    _suggestionsFuture = ApiService.fetchSuggestions();
  }

  Future<void> _showLogoutDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Confirmar Logout'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Você realmente deseja sair?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Sair',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                Navigator.of(context).pushReplacementNamed('/login');
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de investimentos'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            onPressed: _showLogoutDialog,
          ),
        ],
      ),
      body: FutureBuilder<List<Suggestion>>(
        future: _suggestionsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          else if (snapshot.hasError) {
            return Center(
              child: Text('Erro: ${snapshot.error}'),
            );
          }
          else if (snapshot.hasData) {
            final List<Suggestion> suggestions = snapshot.data!;

            return ListView.builder(
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                final Suggestion suggestion = suggestions[index];

                return Card(
                  margin:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailPage(suggestion: suggestion),
                        ),
                      );
                    },
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10.0),
                    horizontalTitleGap: 15.0,
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Image.network(
                        suggestion.imageSmallUrl,
                        fit: BoxFit.contain,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.broken_image, size: 50);
                        },
                      ),
                    ),
                    title: Text(
                      suggestion.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(suggestion.shortDescription),
                  ),
                );
              },
            );
          }
          else {
            return const Center(
              child: Text('Nenhuma sugestão encontrada.'),
            );
          }
        },
      ),
    );
  }
}
