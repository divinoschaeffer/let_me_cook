import 'package:flutter/material.dart';
import '../models/Recipe.dart';

class MiniRecipeCard extends StatelessWidget {
  final Recipe recipe;
  const MiniRecipeCard({
    super.key,
    required this.recipe,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Theme.of(context).colorScheme.surface,
      child: SizedBox(
        height: 80,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10,15,15,10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Text(
                        recipe.meal,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).primaryColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    ),
                    const SizedBox(height: 5),
                    SizedBox(child: Text(
                      "${recipe.category} / ${recipe.area}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      ))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 80,
              child: recipe.mealThumb != null && recipe.mealThumb!.isNotEmpty
              ? Image.network(
                  "${recipe.mealThumb}/preview", // Use the URL if available
                  width: 80.0,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  'assets/images/placeholder.png', // Local placeholder image
                  width: 80.0,
                  fit: BoxFit.cover,
                ),
            )
          ],
        ),
      ),
    );
  }
}
