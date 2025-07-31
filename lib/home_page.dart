import 'package:flutter/material.dart';
import 'package:login_screen_app/api_service.dart'; // Importa nosso serviço de API
import 'package:login_screen_app/suggestion_model.dart'; // Importa nosso modelo
import 'package:login_screen_app/details_page.dart';

class HomePage extends StatefulWidget { // MUDANÇA: Transformamos em StatefulWidget
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Declaramos o Future aqui para que ele não seja chamado repetidamente
  // a cada reconstrução do widget.
  late Future<List<Suggestion>> _suggestionsFuture;

  @override
  void initState() {
    super.initState();
    // Iniciamos a chamada da API aqui, no initState.
    _suggestionsFuture = ApiService.fetchSuggestions();
  }

  Future<void> _showLogoutDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // O usuário deve tocar em um botão para fechar
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
                // Fecha o diálogo
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Sair',
                style: TextStyle(color: Colors.red), // Destaca a ação de sair
              ),
              onPressed: () {
                // Fecha o diálogo
                Navigator.of(dialogContext).pop();
                // FAZ O LOGOUT (navega de volta para a tela de login)
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
        title: const Text('Lista de investimentos'), // Título mais descritivo
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout, // Ícone padrão de logout
              color: Colors.red, // Cor do ícone
            ),
              onPressed: _showLogoutDialog,
          ),
        ],
      ),
      body: FutureBuilder<List<Suggestion>>(
        future: _suggestionsFuture, // O Future que o builder vai observar
        builder: (context, snapshot) {
          // 1. Enquanto os dados estão carregando
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(), // Mostra um círculo de progresso
            );
          }
          // 2. Se ocorreu um erro
          else if (snapshot.hasError) {
            return Center(
              child: Text('Erro: ${snapshot.error}'), // Mostra a mensagem de erro
            );
          }
          // 3. Se os dados chegaram com sucesso
          else if (snapshot.hasData) {
            // Pegamos a lista de sugestões do snapshot
            final List<Suggestion> suggestions = snapshot.data!;

            // Usamos um ListView.builder para construir a lista de forma eficiente
            return ListView.builder(
              itemCount: suggestions.length, // O número de itens na lista
              itemBuilder: (context, index) {
                // Pega a sugestão atual com base no índice
                final Suggestion suggestion = suggestions[index];

                // Retorna um widget para exibir a sugestão (usaremos um ListTile)
                return Card( // Envolve o ListTile em um Card para um visual melhor
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    onTap: () {
                      // Navega para a página de detalhes quando um item é clicado
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(suggestion: suggestion),
                        ),
                      );
                    },

                    contentPadding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                    horizontalTitleGap: 15.0,
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Image.network(
                        suggestion.imageSmallUrl, // MUDANÇA: Usar a imagem pequena
                        //width: 80,
                        //height: 80,
                        fit: BoxFit.contain,
                        // Adiciona um frame de carregamento e erro para a imagem
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(child: CircularProgressIndicator());
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.broken_image, size: 50);
                        },
                      ),
                    ),
                    // Título
                    title: Text(
                      suggestion.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    // Descrição
                    subtitle: Text(suggestion.shortDescription),
                  ),
                );
              },
            );
          }
          // 4. Caso padrão (não deve acontecer em um FutureBuilder bem configurado)
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
