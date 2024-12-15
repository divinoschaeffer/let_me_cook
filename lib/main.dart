import 'package:flutter/material.dart';
import 'package:let_me_cook/views/pages/home_page.dart';
import 'package:let_me_cook/views/widget/navigation_menu.dart';
import 'repository/recipe_repository.dart';
import 'theme/theme.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});
  final RecipeRepository recipeRepository = RecipeRepository();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: const SafeArea(
        child: Scaffold(
          body: HomePage(),
          bottomNavigationBar: NavigationMenuWidget(),
        ),
      ),
    );
  }
}
