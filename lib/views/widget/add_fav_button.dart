import 'package:flutter/material.dart';
import 'package:let_me_cook/models/recipe.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';


class AddToFavoritesButton extends StatelessWidget {
  final Recipe recipe;
  String jsonText = "";

  AddToFavoritesButton({Key? key, required this.recipe}) : super(key: key);

  // Function to add the recipe to JSON file
  Future<void> _addToFavorites() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/favorites.json');
      print('${directory.path}/favorites.json');
      // Read the current favorites from the file
      List<dynamic> currentFavorites = [];
      if (await file.exists()) {
        final jsonString = await file.readAsString();
        currentFavorites = jsonDecode(jsonString);
      }

      // Add the new recipe to the file
      currentFavorites.add(recipe.toJson());

      // Save the new file
      await file.writeAsString(jsonEncode(currentFavorites));

      print("The recipe was successfully added to favorites.");
    } catch (e) {
      print("Could not add the recipe to the favorites : $e");
    }
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: _addToFavorites,
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 50),
        ),
        child: Text("Add to favorites"),
      ),
    );
  }
}
