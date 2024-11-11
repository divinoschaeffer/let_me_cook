import 'package:flutter/foundation.dart';

import '../models/recipe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RecipeApi {
  final String _baseUrl = 'themealdb.com';
  final String _apiPath = '/api/json/v1/1';
  final String _random = '/random.php';

  Future<Recipe> fetchRandomRecipe() async {
    Uri uri = Uri.https(_baseUrl, _apiPath + _random);
    print(uri);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      final recipe = data['meals'][0];
      return Recipe.fromJson(recipe);
    } else {
      throw Exception("Error while fetching recipe");
    }
  }
}