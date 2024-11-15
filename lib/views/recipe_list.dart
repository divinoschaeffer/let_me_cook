import 'package:flutter/material.dart';
import 'package:let_me_cook/models/Recipe.dart';
import 'package:let_me_cook/views/mini_recipe_card.dart';

class RecipeList extends StatefulWidget {
  final List<Recipe> recipes;

  const RecipeList({super.key, required this.recipes});

  @override
  _RecipeListState createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.recipes.length,
      itemBuilder: (context, index) {
        final recipe = widget.recipes[index];
        return MiniRecipeCard(recipe: recipe);
      },
    );
  }

  @override
  void didUpdateWidget(covariant RecipeList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.recipes != widget.recipes) {
      setState(() {});
    }
  }
}
