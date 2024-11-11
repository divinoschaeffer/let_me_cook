import 'package:let_me_cook/models/recipe.dart';
import '../data/recipe_api.dart';

class RecipeRepository {
  final RecipeApi _recipeApi = RecipeApi();

  Future<Recipe> getRandomRecipe() async {
    return await _recipeApi.fetchRandomRecipe();
  }
}