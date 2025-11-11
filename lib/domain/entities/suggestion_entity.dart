class SuggestionEntity {
  final String? imageSmall;
  final String? name;
  final String? shortDescription;
  final String? imageLarge;
  final String? description;

  SuggestionEntity({
    required this.imageSmall,
    required this.name,
    required this.shortDescription,
    required this.imageLarge,
    required this.description,
  });

  factory SuggestionEntity.fromJson(Map<String, dynamic> json) {
    return SuggestionEntity(
      imageSmall: json['imageSmall'],
      name: json['name'],
      shortDescription: json['shortDescription'],
      imageLarge: json['imageLarge'],
      description: json['description'],
    );
  }
}
