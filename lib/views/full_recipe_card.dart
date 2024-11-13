import 'package:flutter/material.dart';
import 'package:let_me_cook/models/Ingredient.dart';
import 'package:let_me_cook/models/recipe.dart';

class FullRecipeCard extends StatelessWidget {
  final Recipe recipe;
  const FullRecipeCard({
    required this.recipe,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child:  recipe.mealThumb != null && recipe.mealThumb!.isNotEmpty 
          ? Image.network(
              recipe.mealThumb!,
              width: double.infinity,
              fit: BoxFit.cover,
            )
          : Image.asset(
            'assets/images/placeholder.png',
            fit: BoxFit.cover,
          )
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "CATEGORIE- ${recipe.category.toUpperCase()}",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).primaryColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Center(
                child: Text(
                  recipe.meal,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "INGREDIENTS",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 5,
              ),
              IngredientsList(
                ingredients: recipe.ingredients
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "RECIPE",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.start,
              ),
              Text(
                recipe.instructions,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.start,
              ),
            ],
          ),
        )
      ],
    );
  }
}

class IngredientsList extends StatelessWidget {
  final List<Ingredient> ingredients;
  const IngredientsList({
    super.key,
    required this.ingredients,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        childAspectRatio: 3
      ),
      itemCount: ingredients.length,
      itemBuilder: (context, index) {
        final ingredient = ingredients[index];
        return Container(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                ingredient.thumb,
                height: 25,
              ),
              Text(
                "${ingredient.measure} ${ingredient.name}",
                maxLines: 1,
                overflow: TextOverflow.clip,
              )
            ],
          )
        );
      },
    );
  }
}
