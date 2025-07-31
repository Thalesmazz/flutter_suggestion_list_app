// Em lib/detail_page.dart

import 'package:flutter/material.dart';
import 'package:login_screen_app/suggestion_model.dart'; // Precisamos do nosso modelo

class DetailPage extends StatelessWidget {
  // A tela de detalhes precisa de uma sugestão para exibir.
  final Suggestion suggestion;

  // O construtor recebe o objeto 'suggestion' que foi clicado.
  const DetailPage({
    super.key,
    required this.suggestion, // Este parâmetro é obrigatório
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // O título da AppBar será o título da sugestão
        title: Text(suggestion.title),
      ),
      body: SingleChildScrollView( // Permite rolagem para conteúdo grande
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Estica os filhos horizontalmente
          children: [
            // Imagem Grande no Topo
            Image.network(
              suggestion.imageLargeUrl, // Usamos a mesma URL por enquanto
              height: 250, // Uma altura maior para destaque
              fit: BoxFit.cover, // Cover fica bom para imagens de destaque
            ),
            // Padding para o conteúdo de texto
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título
                  Text(
                    suggestion.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0), // Espaço
                  // Descrição
                  Text(
                    suggestion.fullDescription,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5, // Melhora a legibilidade do texto
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
