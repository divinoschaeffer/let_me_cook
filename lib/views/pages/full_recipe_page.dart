import 'package:flutter/material.dart';
import '../../models/recipe.dart';
import '../widget/full_recipe_card.dart';

class FullRecipePage extends StatelessWidget {
  final Recipe recipe;

  const FullRecipePage({
    super.key,
    required this.recipe,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FullRecipeCardWidget(recipe: recipe),
      ),
    );
  }
}
