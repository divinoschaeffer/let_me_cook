import 'package:flutter/material.dart';
import '../../models/recipe.dart';
import '../widget/full_recipe_card.dart';
import '../widget/add_fav_button.dart';

class FullRecipePage extends StatefulWidget {
  final Recipe recipe;

  const FullRecipePage({
    super.key,
    required this.recipe,
  });

  @override
  _FullRecipePageState createState() => _FullRecipePageState();
}

class _FullRecipePageState extends State<FullRecipePage> {
  bool _favoritesChanged = false;

  void _onFavoriteToggled() {
    setState(() {
      _favoritesChanged = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, _favoritesChanged);
        return false;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FullRecipeCardWidget(recipe: widget.recipe),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Explore the recipe and don't forget to save it if you like it!",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: AddToFavoritesButton(
          recipe: widget.recipe,
          onFavoriteChanged: _onFavoriteToggled,
        ),
      ),
    );
  }
}
