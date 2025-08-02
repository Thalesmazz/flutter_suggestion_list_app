class Suggestion {
  final String imageSmallUrl;
  final String title;
  final String shortDescription;
  final String imageLargeUrl;
  final String fullDescription;

  Suggestion({
    required this.imageSmallUrl,
    required this.title,
    required this.shortDescription,
    required this.imageLargeUrl,
    required this.fullDescription,
  });

  factory Suggestion.fromJson(Map<String, dynamic> json) {
    return Suggestion(
      imageSmallUrl: json['imageSmall'] ?? 'https://via.placeholder.com/150',
      title: json['name'] ?? 'Título não encontrado',
      shortDescription:
      json['shortDescription'] ?? 'Descrição não encontrada',
      imageLargeUrl: json['imageLarge'] ??
          json['imageSmall'] ??
          'https://via.placeholder.com/400',
      fullDescription: json['description'] ??
          json['shortDescription'] ??
          'Descrição completa não encontrada',
    );
  }
}
