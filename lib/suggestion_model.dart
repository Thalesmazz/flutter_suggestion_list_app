// Em lib/suggestion_model.dart

class Suggestion {
  final String imageSmallUrl;
  final String title;
  final String shortDescription;
  // NOVAS PROPRIEDADES para a DetailPage
  final String imageLargeUrl;
  final String fullDescription;

  Suggestion({
    required this.imageSmallUrl,
    required this.title,
    required this.shortDescription,
    required this.imageLargeUrl,
    required this.fullDescription,
  });

  // O construtor de fábrica agora vai extrair os dados das chaves corretas
  factory Suggestion.fromJson(Map<String, dynamic> json) {
    return Suggestion(
      // Mapeamento para a lista
      imageSmallUrl: json['imageSmall'] ?? 'https://via.placeholder.com/150',
      title: json['name'] ?? 'Título não encontrado',
      shortDescription: json['shortDescription'] ?? 'Descrição não encontrada',

      // Mapeamento para os detalhes
      imageLargeUrl: json['imageLarge'] ?? json['imageSmall'] ?? 'https://via.placeholder.com/400',
      fullDescription: json['description'] ?? json['shortDescription'] ?? 'Descrição completa não encontrada',
    );
  }
}
