import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:let_me_cook/models/recipe.dart';

class AddToFavoritesButton extends StatefulWidget {
  final Recipe recipe;

  const AddToFavoritesButton({Key? key, required this.recipe}) : super(key: key);

  @override
  _AddToFavoritesButtonState createState() => _AddToFavoritesButtonState();
}

class _AddToFavoritesButtonState extends State<AddToFavoritesButton> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkIfFavorite();
  }

  Future<void> _checkIfFavorite() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/favorites.json');

    if (await file.exists()) {
      final jsonString = await file.readAsString();
      final List<dynamic> currentFavorites = jsonDecode(jsonString);

      // Vérifie si la recette est déjà dans les favoris
      setState(() {
        _isFavorite = currentFavorites.any(
              (favorite) => favorite['idMeal'] == widget.recipe.idMeal,
        );
      });
    }
  }

  Future<void> _toggleFavorite() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/favorites.json');

      List<dynamic> currentFavorites = [];
      if (await file.exists()) {
        final jsonString = await file.readAsString();
        currentFavorites = jsonDecode(jsonString);
      }

      if (_isFavorite) {
        currentFavorites.removeWhere(
              (favorite) => favorite['idMeal'] == widget.recipe.idMeal,
        );
      } else {
        currentFavorites.add(widget.recipe.toJson());
      }

      // Save in file
      await file.writeAsString(jsonEncode(currentFavorites));

      // Update local state
      setState(() {
        _isFavorite = !_isFavorite;
      });
      print(_isFavorite
          ? 'Recipe added to favorites.'
          : 'Recipe removed from favorites.');
    } catch (e) {
      print("Could not toggle the favorite state: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: _toggleFavorite,
      backgroundColor: _isFavorite ? Colors.red : Colors.grey,
      child: Icon(
        _isFavorite ? Icons.favorite : Icons.favorite_border,
        color: Colors.white,
      ),
    );
  }
}
