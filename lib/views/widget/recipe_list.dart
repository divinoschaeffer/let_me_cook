import 'package:flutter/material.dart';
import 'package:let_me_cook/models/recipe.dart';
import 'package:let_me_cook/views/widget/mini_recipe_card.dart';

class RecipeListWidget extends StatefulWidget {
  final List<Recipe> recipes;
  final VoidCallback? onFavoritesChanged;

  const RecipeListWidget({super.key, required this.recipes, this.onFavoritesChanged,});

  @override
  _RecipeListWidgetState createState() => _RecipeListWidgetState();
}

class _RecipeListWidgetState extends State<RecipeListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.recipes.length,
      itemBuilder: (context, index) {
        final recipe = widget.recipes[index];
        return MiniRecipeCard(recipe: recipe, onFavoritesChanged: widget.onFavoritesChanged);
      },
    );
  }

  @override
  void didUpdateWidget(covariant RecipeListWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.recipes != widget.recipes) {
      setState(() {});
    }
  }
}
