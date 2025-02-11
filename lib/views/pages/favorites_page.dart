import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:let_me_cook/models/recipe.dart';
import '../widget/recipe_list.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late Future<List<Recipe>> _favoritesFuture = Future.value([]);

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/favorites.json';
    final file = File(filePath);

    if (await file.exists()) {
      final content = await file.readAsString();
      final List<dynamic> jsonList = jsonDecode(content);

      try {
        List<Recipe> recipes = jsonList.map((json) {
          return Recipe.fromJson(json as Map<String, dynamic>);
        }).toList();
        Future<List<Recipe>> recipesFuture = Future.value(recipes);
        setState(() {
          _favoritesFuture = recipesFuture;
        });
      } catch (e) {
        print("Error parsing recipes: $e");
      }
    } else {
      print("File does not exist.");
    }
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
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          const Text(
            "FAVORITES RECIPES",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.start,
          ),
          Expanded(
              child: FutureBuilder<List<Recipe>>(
                future: _favoritesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text("Failed to load recipes"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("No recipes available"));
                  } else {
                    return RecipeListWidget(
                      recipes: snapshot.data!,
                      onFavoritesChanged: _loadFavorites,
                    );
                  }
                },
              )
          ),
        ],
      ),
    );
  }
}
