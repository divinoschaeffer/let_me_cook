import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:let_me_cook/models/recipe.dart';
import '../../repository/recipe_repository.dart';

class RecipeSearchBarWidget extends StatefulWidget {
  final Function(List<Recipe>) onRecipeListChanged;

  const RecipeSearchBarWidget({
    super.key,
    required this.onRecipeListChanged,
  });

  @override
  _RecipeSearchBarWidgetState createState() => _RecipeSearchBarWidgetState();
}

class _RecipeSearchBarWidgetState extends State<RecipeSearchBarWidget> {
  String? selectedCategory;
  String? selectedArea;
  String? selectedIngredient;
  List<String> categories = [];
  bool isLoadingCategories = false;
  List<String> areas = [];
  bool isLoadingAreas = false;
  List<String> ingredients = [];
  bool isLoadingIngredients = false;
  String? errorMessage;
  String currentQuery = "";

  @override
  void initState() {
    super.initState();
    _loadFilters();
  }

  Future<void> _loadFilters() async {
    _setLoadingState(true);
    try {
      final results = await Future.wait([
        RecipeRepository().fetchCategories(),
        RecipeRepository().fetchAreas(),
        RecipeRepository().fetchIngredients(),
      ]);

      setState(() {
        categories = results[0];
        areas = results[1];
        ingredients = results[2];
      });
    } catch (e) {
      _setErrorState(e.toString());
    } finally {
      _setLoadingState(false);
    }
  }

  void _setLoadingState(bool isLoading) {
    setState(() {
      isLoadingCategories = isLoading;
      isLoadingAreas = isLoading;
      isLoadingIngredients = isLoading;
    });
  }

  void _setErrorState(String? error) {
    setState(() {
      errorMessage = error;
    });
  }

  void _openFilterDialog() {
    String? tempSelectedCategory = selectedCategory;
    String? tempSelectedArea = selectedArea;
    String? tempSelectedIngredient = selectedIngredient;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Filters",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  _buildSearchDropdown(
                    label: "Category",
                    isLoading: isLoadingCategories,
                    errorMessage: errorMessage,
                    items: categories,
                    selectedValue: tempSelectedCategory,
                    onChanged: (value) => setModalState(() {
                      tempSelectedCategory = value;
                    }),
                  ),
                  const SizedBox(height: 10),
                  _buildSearchDropdown(
                    label: "Area",
                    isLoading: isLoadingAreas,
                    items: areas,
                    selectedValue: tempSelectedArea,
                    onChanged: (value) => setModalState(() {
                      tempSelectedArea = value;
                    }),
                  ),
                  const SizedBox(height: 10),
                  _buildSearchDropdown(
                    label: "Ingredient",
                    isLoading: isLoadingIngredients,
                    items: ingredients,
                    selectedValue: tempSelectedIngredient,
                    onChanged: (value) {
                      setModalState(() {
                        tempSelectedIngredient = value == 'None' ? null : value;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        selectedCategory = tempSelectedCategory;
                        selectedArea = tempSelectedArea;
                        selectedIngredient = tempSelectedIngredient;
                      });
                      _onSearch(currentQuery);
                    },
                    child: const Text("Apply Filters"),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSearchDropdown({
    required String label,
    required bool isLoading,
    String? errorMessage,
    required List<String> items,
    required String? selectedValue,
    required void Function(String?) onChanged,
  }) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (errorMessage != null) {
      return Center(child: Text("Error: $errorMessage"));
    } else if (items.isEmpty) {
      return const Center(child: Text("No items available"));
    }

    return DropdownSearch<String>(
      popupProps: PopupProps.menu(
        showSearchBox: true,
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            labelText: "Search $label",
            border: const OutlineInputBorder(),
          ),
        ),
      ),
      items: ['None', ...items],
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
      selectedItem: selectedValue,
      onChanged: onChanged,
    );
  }

  void _onSearch(String query) async {
    List<Recipe> list;

    if (query.isEmpty) {
      list = [];
    } else if (query.length == 1) {
      list = await RecipeRepository().searchRecipeByLetter(query);
    } else {
      list = await RecipeRepository().searchRecipeByIngredient(query);
    }

    list = _filterRecipes(list);
    widget.onRecipeListChanged(list);
  }

  List<Recipe> _filterRecipes(List<Recipe> recipes) {
    List<Recipe> results = recipes;

    if (selectedCategory != null && selectedCategory != "None") {
      results = results.where((recipe) => selectedCategory == recipe.category).toList();
    }
    if (selectedArea != null && selectedArea != "None") {
      results = results.where((recipe) => selectedArea == recipe.area).toList();
    }
    if (selectedIngredient != null && selectedIngredient != "None") {
      results = results.where((recipe) =>
          recipe.ingredients.any((ingredient) => ingredient.name == selectedIngredient)).toList();
    }

    return results;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: SearchBar(
                hintText: 'Enter an ingredient or letter',
                leading: const Icon(Icons.search),
                onChanged: (query) {
                  setState(() {
                    currentQuery = query;
                  });
                  _onSearch(query);
                },
              ),
            ),
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: _openFilterDialog,
            ),
          ],
        ),
        if (selectedCategory != null || selectedArea != null || selectedIngredient != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Wrap(
              spacing: 8.0,
              children: [
                if (selectedCategory != null)
                  _buildFilterChip("Category: $selectedCategory", () {
                    setState(() {
                      selectedCategory = null;
                    });
                    _onSearch(currentQuery);
                  }),
                if (selectedArea != null)
                  _buildFilterChip("Area: $selectedArea", () {
                    setState(() {
                      selectedArea = null;
                    });
                    _onSearch(currentQuery);
                  }),
                if (selectedIngredient != null)
                  _buildFilterChip("Ingredient: $selectedIngredient", () {
                    setState(() {
                      selectedIngredient = null;
                    });
                    _onSearch(currentQuery);
                  }),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildFilterChip(String label, VoidCallback onDeleted) {
    return Chip(
      label: Text(label),
      onDeleted: onDeleted,
    );
  }
}
