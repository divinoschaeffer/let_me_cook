import 'package:flutter/material.dart';
import "../../repository/recipe_repository.dart";

class RecipeSearchBarWidget extends StatefulWidget {
  const RecipeSearchBarWidget({super.key});

  @override
  State<RecipeSearchBarWidget> createState() => _RecipeSearchBarWidgetState();
}

class _RecipeSearchBarWidgetState extends State<RecipeSearchBarWidget> {
  @override
  Widget build(BuildContext context) {
    return SearchBar(
      hintText: 'Enter ingredient, recipe name, ...',
      leading: const Icon(Icons.search),
      onChanged: (query) {
        RecipeRepository().searchRecipeByIngredient(query);
      },
    );
  }
}
