class Ingredient {
  final String name;
  final String measure;
  final String thumb;

  Ingredient({
    required this.name,
    required this.measure,
    required this.thumb,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'measure': measure,
      'thumb': thumb,
    };
  }
}