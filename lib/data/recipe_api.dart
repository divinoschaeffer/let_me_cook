import '../models/recipe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RecipeApi {
  static const String _baseUrl = 'themealdb.com';
  static const String _apiPath = '/api/json/v1/1';
  static const String _random = '/random.php';
  static const String _list = '/list.php';
  static const String _filter = '/filter.php';
  static const String _lookup = '/lookup.php';
  static const String _search = '/search.php';
  static const String _letter = 'f';
  static const String _categorie = 'c';
  static const String _ingredient = 'i';
  static const String _id = 'i';
  static const String _area = 'a';

  Future<Recipe> fetchRandomRecipe() async {
    Uri uri = Uri.https(
      _baseUrl,
      _apiPath + _random
    );
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      final recipe = data['meals'][0];
      return Recipe.fromJson(recipe);
    } else {
      throw Exception("Error while fetching recipe");
    }
  }

  Future<List<int>> searchByIngredient(String ingredient) async {
    final Uri uri = Uri.https(
      _baseUrl,
      _apiPath + _filter,
      {_ingredient: ingredient},
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data['meals'] != null) {
        List<int> ids = (data['meals'] as List).map((meal) {
          return int.parse(meal['idMeal']);
        }).toList();
        return ids;
      } else {
        return [];
      }
    } else {
      throw Exception("Error while searching for recipes");
    }
  }

  Future<List<Recipe>> searchByLetter(String letter) async {
    final Uri uri = Uri.https(
      _baseUrl,
      _apiPath + _search,
      {_letter: letter},
    );

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

  Future<Recipe?> searchById(int id) async {
  final Uri uri = Uri.https(
    _baseUrl,
    _apiPath + _lookup,
    {_id: id.toString()},
  );

  final response = await http.get(uri);

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);

    if (data['meals'] != null && data['meals'].isNotEmpty) {
      return Recipe.fromJson(data['meals'][0]);
    } else {
      return null;
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