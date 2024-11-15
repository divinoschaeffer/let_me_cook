import 'package:flutter/material.dart';
import "../repository/recipe_repository.dart";

class RecipeSearchBar extends StatefulWidget {
  const RecipeSearchBar({super.key});

  @override
  State<RecipeSearchBar> createState() => _RecipeSearchBarState();
}

class _RecipeSearchBarState extends State<RecipeSearchBar> {
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
