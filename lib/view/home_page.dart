import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/suggestion_model.dart';
import '../viewmodel/home_viewmodel.dart';
import 'package:provider/provider.dart';
import './widgets/logout_dialog.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de investimentos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.red),
            onPressed: () async {
              final bool? shouldLogout = await showDialog<bool>(
                context: context,
                builder: (context) => const LogoutDialog(),
              );

              if (shouldLogout == true) {
                context.go('/login');
              }
            },
          ),
        ],
      ),
      body: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          switch (viewModel.state) {
            case ViewState.loading:
              return const Center(child: CircularProgressIndicator());
            case ViewState.error:
              return Center(child: Text(viewModel.errorMessage));
            case ViewState.success:
              return ListView.builder(
                itemCount: viewModel.suggestions.length,
                itemBuilder: (context, index) {
                  final Suggestion suggestion = viewModel.suggestions[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: ListTile(
                      onTap: () {
                        context.go('/details', extra: suggestion);
                      },
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15.0,
                        vertical: 10.0,
                      ),
                      horizontalTitleGap: 15.0,
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Image.network(
                          suggestion.imageSmallUrl,
                          fit: BoxFit.contain,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
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
            default:
              return const Center(child: Text('Bem-vindo!'));
          }
        },
      ),
    );
  }
}
