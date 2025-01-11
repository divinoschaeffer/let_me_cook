import 'ingredient.dart';

class Recipe {
  final String idMeal;
  final String meal;
  final String? drinkAlternate;
  final String category;
  final String area;
  final String instructions;
  final String? mealThumb;
  final String? tags;
  final String? youtube;
  final List<Ingredient> ingredients;
  final String? source;
  final String? imageSource;
  final String? creativeCommonsConfirmed;
  final DateTime? dateModified;

  Recipe({
    required this.idMeal,
    required this.meal,
    this.drinkAlternate,
    required this.category,
    required this.area,
    required this.instructions,
    required this.mealThumb,
    this.tags,
    this.youtube,
    required this.ingredients,
    this.source,
    this.imageSource,
    this.creativeCommonsConfirmed,
    this.dateModified,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    List<Ingredient> ingredients = [];

    for (int i = 1; i <= 20; i++) {
      String ingredientKey = 'strIngredient$i';
      String measureKey = 'strMeasure$i';

      String? ingredient = json[ingredientKey];
      String? measure = json[measureKey];

      if (ingredient != null && ingredient.isNotEmpty) {
        ingredients.add(
          Ingredient(
            name: ingredient,
            measure: measure ?? '',
            thumb: "https://www.themealdb.com/images/ingredients/$ingredient-Small.png"
          ),
        );
      }
    }

    return Recipe(
      idMeal: json['idMeal'],
      meal: json['strMeal'],
      drinkAlternate: json['strDrinkAlternate'],
      category: json['strCategory'],
      area: json['strArea'],
      instructions: json['strInstructions'],
      mealThumb: json['strMealThumb'],
      tags: json['strTags'],
      youtube: json['strYoutube'],
      ingredients: ingredients,
      source: json['strSource'],
      imageSource: json['strImageSource'],
      creativeCommonsConfirmed: json['strCreativeCommonsConfirmed'],
      dateModified: json['dateModified'] != null
          ? DateTime.tryParse(json['dateModified']) // Conversion sécurisée
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {
      'idMeal': idMeal,
      'strMeal': meal,
      'strDrinkAlternate': drinkAlternate,
      'strCategory': category,
      'strArea': area,
      'strInstructions': instructions,
      'strMealThumb': mealThumb,
      'strTags': tags,
      'strYoutube': youtube,
      'strSource': source,
      'strImageSource': imageSource,
      'strCreativeCommonsConfirmed': creativeCommonsConfirmed,
      'strDateModified': dateModified?.toIso8601String(),
    };

    for (int i = 0; i < ingredients.length; i++) {
      final ingredient = ingredients[i];
      json['strIngredient${i + 1}'] = ingredient.name;
      json['strMeasure${i + 1}'] = ingredient.measure;
    }

    return json;
  }

}