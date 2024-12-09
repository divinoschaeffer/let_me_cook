import 'package:flutter/material.dart';
import '../../repository/recipe_repository.dart';

class RecipeSearchBarWidget extends StatefulWidget {
  const RecipeSearchBarWidget({super.key});

  @override
  State<RecipeSearchBarWidget> createState() => _RecipeSearchBarWidgetState();
}

class _RecipeSearchBarWidgetState extends State<RecipeSearchBarWidget> {
  String? selectedCategory;
  String? selectedArea;
  List<String> categories = [];
  bool isLoadingCategories = false;
  List<String> areas = [];
  bool isLoadingAreas = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadCategoriesAndAreas();
  }

  Future<void> _loadCategoriesAndAreas() async {
    setState(() {
      isLoadingCategories = true;
      isLoadingAreas = true;
      errorMessage = null;
    });

    try {
      final fetchedCategories = await RecipeRepository().fetchCategories();
      final fetchedAreas = await RecipeRepository().fetchAreas();
      setState(() {
        categories = fetchedCategories;
        areas = fetchedAreas;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    } finally {
      setState(() {
        isLoadingCategories = false;
        isLoadingAreas = false;
      });
    }
  }

  void _openFilterDialog() {
    String? tempSelectedCategory = selectedCategory;
    String? tempSelectedArea = selectedArea;

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
                  if (isLoadingCategories)
                    const Center(child: CircularProgressIndicator())
                  else if (errorMessage != null)
                    Center(child: Text("Error: $errorMessage"))
                  else if (categories.isNotEmpty)
                    DropdownButtonFormField<String>(
                      value: tempSelectedCategory,
                      items: ['None', ...categories]
                          .map((category) => DropdownMenuItem(
                                value: category == 'None' ? null : category,
                                child: Text(category),
                              ))
                          .toList(),
                      decoration: const InputDecoration(labelText: "Category"),
                      onChanged: (value) {
                        setModalState(() {
                          tempSelectedCategory = value;
                        });
                      },
                    )
                  else
                    const Center(child: Text("No categories available")),
                  const SizedBox(height: 10),
                  if (isLoadingAreas)
                    const Center(child: CircularProgressIndicator())
                  else
                    DropdownButtonFormField<String>(
                      value: tempSelectedArea,
                      items: ['None', ...areas]
                          .map((area) => DropdownMenuItem(
                                value: area == 'None' ? null : area,
                                child: Text(area),
                              ))
                          .toList(),
                      decoration: const InputDecoration(labelText: "Area"),
                      onChanged: (value) {
                        setModalState(() {
                          tempSelectedArea = value;
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
                      });
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

  void _onSearch(String query) {
    RecipeRepository().searchRecipeByIngredient(query);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: SearchBar(
                hintText: 'Enter an ingredient',
                leading: const Icon(Icons.search),
                onChanged: _onSearch,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: _openFilterDialog,
            ),
          ],
        ),
        if (selectedCategory != null || selectedArea != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Wrap(
              spacing: 8.0,
              children: [
                if (selectedCategory != null)
                  Chip(
                    label: Text("Cat: $selectedCategory"),
                    onDeleted: () {
                      setState(() {
                        selectedCategory = null;
                      });
                    },
                  ),
                if (selectedArea != null)
                  Chip(
                    label: Text("Area: $selectedArea"),
                    onDeleted: () {
                      setState(() {
                        selectedArea = null;
                      });
                    },
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
