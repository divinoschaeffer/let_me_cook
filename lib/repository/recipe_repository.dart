import 'package:let_me_cook/models/Recipe.dart';
import '../data/recipe_api.dart';

class RecipeRepository {
  final RecipeApi _recipeApi = RecipeApi();

  Future<Recipe> getRandomRecipe() async {
    return await _recipeApi.fetchRandomRecipe();
  }

  Future<List<Recipe>> getMultipleRandomRecipe(int number) async {
    List<Future<Recipe>> futures = List.generate(number, (_) => _recipeApi.fetchRandomRecipe());
    return await Future.wait(futures);
  }

  Future<List<Recipe>> searchRecipeByIngredient(String ingredient) async {
    return await _recipeApi.searchByIngredient(ingredient);
  }

  Future<List<Recipe>> searchRecipeByCategorie(String categorie) async {
    return await _recipeApi.searchByCategorie(categorie);
  }
  
  Future<List<Recipe>> searchRecipeByArea(String area) async {
    return await _recipeApi.searchByArea(area);
  }
}