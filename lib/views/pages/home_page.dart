import 'package:flutter/material.dart';
import 'package:let_me_cook/models/recipe.dart';
import 'package:let_me_cook/repository/recipe_repository.dart';
import '../widget/recipe_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  late Future<List<Recipe>> _recipesFuture;

  Future<List<Recipe>> _fetchDailyRecipes() async {
    print(1);
    return await RecipeRepository().getMultipleRandomRecipe(10);
  }

  @override
  void initState() {
    super.initState();
    _recipesFuture = _fetchDailyRecipes();
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "LET ME COOK !",
              style: TextStyle(
                fontSize: 24,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w900,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05
          ),
          const Text(
            "DAYLY RECIPES",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            textAlign: TextAlign.start,
          ),
          Expanded(
            child: FutureBuilder<List<Recipe>>(
              future: _recipesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text("Failed to load recipes"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No recipes available"));
                } else {
                  return RecipeListWidget(recipes: snapshot.data!);
                }
              },
            )
          )
        ],
      ),
    );
  }
}
