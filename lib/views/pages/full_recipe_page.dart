import 'package:flutter/material.dart';
import '../../models/recipe.dart';
import '../widget/full_recipe_card.dart';
import '../widget/add_fav_button.dart';

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FullRecipeCardWidget(recipe: recipe),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: AddToFavoritesButton(recipe: recipe,)
            ),
          ],
        ),
      ),
    );
  }

}
