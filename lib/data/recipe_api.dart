import '../models/recipe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RecipeApi {
  final String _baseUrl = 'themealdb.com';
  final String _apiPath = '/api/json/v1/1';
  final String _random = '/random.php';
  final String _list = '/list.php';
  final String _ingredient = 'i';
  final String _categorie = 'c';
  final String _area = 'a';

  Future<Recipe> fetchRandomRecipe() async {
    Uri uri = Uri.https(_baseUrl, _apiPath + _random);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      final recipe = data['meals'][0];
      return Recipe.fromJson(recipe);
    } else {
      throw Exception("Error while fetching recipe");
    }
  }

  Future<List<Recipe>> searchByIngredient(String ingredient)  async {
    Uri uri = Uri.https(_baseUrl, _apiPath, {_ingredient: ingredient});
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      if (data['meals'] != null) {
        List<Recipe> recipes = (data['meals'] as List).map((meal) {
          return Recipe.fromJson(meal);
        }).toList();
        return recipes;
      } else {
        return [];
      }
    } else {
      throw Exception("Error while searching for recipes");
    }
  }

  Future<List<Recipe>> searchByCategorie(String categorie)  async {
    Uri uri = Uri.https(_baseUrl, _apiPath, {_categorie: categorie});
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      if (data['meals'] != null) {
        List<Recipe> recipes = (data['meals'] as List).map((meal) {
          return Recipe.fromJson(meal);
        }).toList();
        return recipes;
      } else {
        return [];
      }
    } else {
      throw Exception("Error while searching for recipes");
    }
  }
  
  Future<List<Recipe>> searchByArea(String area)  async {
    Uri uri = Uri.https(_baseUrl, _apiPath, {_area: area});
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      if (data['meals'] != null) {
        List<Recipe> recipes = (data['meals'] as List).map((meal) {
          return Recipe.fromJson(meal);
        }).toList();
        return recipes;
      } else {
        return [];
      }
    } else {
      throw Exception("Error while searching for recipes");
    }
  }

  Future<List<String>> fetchCategories() async {
    Uri uri = Uri.https(_baseUrl, _apiPath + _list, {_categorie: 'list'});
    final response = await http.get(uri);
    if (response.statusCode == 200){
      dynamic data = json.decode(response.body);
      if (data['meals'] != null) {
        List<String> categories = (data['meals'] as List).map((cat) {
          return cat['strCategory'] as String;
        }).toList();
        return categories;
      } else {
        return [];
      }
    } else {
      throw Exception("Error getting categories");
    }
  }
  
  Future<List<String>> fetchAreas() async {
    Uri uri = Uri.https(_baseUrl, _apiPath + _list, {_area: 'list'});
    final response = await http.get(uri);
    if (response.statusCode == 200){
      dynamic data = json.decode(response.body);
      if (data['meals'] != null) {
        List<String> areas = (data['meals'] as List).map((area) {
          return area['strArea'] as String;
        }).toList();
        return areas;
      } else {
        return [];
      }
    } else {
      throw Exception("Error getting categories");
    }
  }
}