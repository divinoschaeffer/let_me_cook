import 'package:flutter/material.dart';
import '../widget/recipe_search_bar.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: RecipeSearchBarWidget(),
    );
  }
}