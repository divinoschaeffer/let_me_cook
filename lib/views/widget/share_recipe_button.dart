import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:let_me_cook/models/recipe.dart';

class ShareRecipeButton extends StatelessWidget {
  final Recipe recipe;

  const ShareRecipeButton({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  void _shareRecipe(BuildContext context) {
    try {
      if (recipe.meal.isEmpty || recipe.ingredients.isEmpty || recipe.instructions.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Unable to share recipe: Missing essential information.')),
        );
        return;
      }

      final message = """
Check out this recipe: ${recipe.meal}

Category: ${recipe.category}
Area: ${recipe.area}

Ingredients:
${recipe.ingredients.map((i) => "- ${i.name} (${i.measure})").join("\n")}

Instructions:
${recipe.instructions}

Enjoy your meal!
""";

      Share.share(message, subject: 'Delicious Recipe: ${recipe.meal}');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to share the recipe: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _shareRecipe(context),
      backgroundColor: Colors.blue,
      child: const Icon(
        Icons.share,
        color: Colors.white,
      ),
    );
  }
}
