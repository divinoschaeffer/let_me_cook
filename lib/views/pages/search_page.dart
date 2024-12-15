import 'package:flutter/material.dart';
import 'package:let_me_cook/models/recipe.dart';
import 'package:let_me_cook/views/widget/recipe_list.dart';
import '../widget/recipe_search_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  List<Recipe> recipeList = [];

  void updateRecipeList(List<Recipe> newRecipeList) {
    setState(() {
      recipeList = newRecipeList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          RecipeSearchBarWidget(
            onRecipeListChanged: updateRecipeList,
          ),
          Expanded(child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: RecipeListWidget(recipes: recipeList),
          ))
        ],
      ),
    );
  }
}