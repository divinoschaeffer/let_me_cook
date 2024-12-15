import 'package:let_me_cook/models/recipe.dart';
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
    List<int> ids = await _recipeApi.searchByIngredient(ingredient);

    List<Recipe?> recipes = await Future.wait(
      ids.map((id) => _recipeApi.searchById(id))
    );

    List<Recipe> filteredRecipes = recipes.where((recipe) => recipe != null).cast<Recipe>().toList();

    return filteredRecipes;
  }

  Future<List<Recipe>> searchRecipeByLetter(String letter) async {
    return await _recipeApi.searchByLetter(letter);
  } 

  Future<List<Recipe>> searchRecipeByCategorie(String categorie) async {
    return await _recipeApi.searchByCategorie(categorie);
  }
  
  Future<List<Recipe>> searchRecipeByArea(String area) async {
    return await _recipeApi.searchByArea(area);
  }

  Future<List<String>> fetchCategories() async {
    return await _recipeApi.fetchCategories();
  }
  
  Future<List<String>> fetchAreas() async {
    return await _recipeApi.fetchAreas();
  }

  Future<List<String>> fetchIngredients() async {
    return await _recipeApi.fetchIngredients();
  }
}