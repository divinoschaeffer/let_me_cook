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
      idMeal: json['idMeal'] ?? '', // Valeur par défaut pour éviter les null
      meal: json['strMeal'] ?? json['meal'], // Valeur par défaut
      drinkAlternate: json['strDrinkAlternate'] ?? json['drinkAlternate'], // Nullable
      category: json['strCategory'] ?? json['category'], // Valeur par défaut
      area: json['strArea'] ??  json['area'] , // Valeur par défaut
      instructions: json['strInstructions'] ?? json['instructions'], // Valeur par défaut
      mealThumb: json['strMealThumb'] ?? json['mealThumb'], // Nullable
      tags: json['strTags'] ?? json['tags'], // Nullable
      youtube: json['strYoutube'] ?? json['youtube'], // Nullable
      ingredients: ingredients, // Liste construite
      source: json['strSource'], // Nullable
      imageSource: json['strImageSource'] ?? json['imageSource'], // Nullable
      creativeCommonsConfirmed: json['strCreativeCommonsConfirmed'] ?? json['creativeCommonsConfirmed'], // Nullable
      dateModified: json['dateModified'] != null
          ? DateTime.tryParse(json['dateModified']) // Conversion sécurisée
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idMeal': idMeal,
      'meal': meal,
      'drinkAlternate': drinkAlternate,
      'category': category,
      'area': area,
      'instructions': instructions,
      'mealThumb': mealThumb,
      'tags': tags,
      'youtube': youtube,
      'ingredients': ingredients.map((ingredient) => ingredient.toJson()).toList(),
      'source': source,
      'imageSource': imageSource,
      'creativeCommonsConfirmed': creativeCommonsConfirmed,
      'dateModified': dateModified?.toIso8601String(),
    };
  }
}