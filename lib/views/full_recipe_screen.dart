import 'package:flutter/material.dart';
import 'package:let_me_cook/views/navigation_bar.dart';
import '../models/Recipe.dart';
import 'full_recipe_card.dart';

class FullRecipeScreen extends StatelessWidget {
  final Recipe recipe;

  const FullRecipeScreen({
    super.key,
    required this.recipe,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FullRecipeCard(recipe: recipe),
      ),
    );
  }
}
