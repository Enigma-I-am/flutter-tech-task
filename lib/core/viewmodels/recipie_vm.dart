import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:tech_task/core/core.dart';

class RecipeVM extends DisposableViewModel {
  final RecipeRepository _recipieRepository;
  RecipeVM(
    super.ref, {
    required RecipeRepository recipieRepository,
  }) : _recipieRepository = recipieRepository;

  TextEditingController searchTEC = TextEditingController(text: DateTime.now().date.toString());

  List<IngredientModel> _ingredients = [];
  List<IngredientModel> get ingredients => _ingredients;
  set ingredients(List<IngredientModel> val) {
    _ingredients = val;
    notifyListeners();
  }

  List<Recipiemodel>? _recipies = [];
  List<Recipiemodel>? get recipies => _recipies;
  set recipies(List<Recipiemodel>? val) {
    _recipies = val;
    notifyListeners();
  }

  Future<void> loadIngredient() async {
    await loader.runTask(
      () async {
        final res = await _recipieRepository.getIngredients();

        res.match(
          onSuccess: (res) => ingredients = res,
          onError: (err) => ingredients = [],
        );
      },
    );
  }

  Future<void> loadRecipies() async {
    await loader.runTask(() async {
      final selectedIngredients = (ingredients)
          .where((element) => element.selected == true)
          .map((e) => e.title)
          .toList();

      if (selectedIngredients.isEmpty) {
        recipies =
            []; // Set recipies to an empty list when no ingredients are selected
        return;
      }

      final res = await _recipieRepository.getRecipies(
        selectedIngredients: selectedIngredients,
      );

      res.match(
        onSuccess: (r) => recipies = r,
        onError: (err) => recipies = null,
      );
    });
  }

  void toggle(IngredientModel ingredient) {
    final ingredientsCopy = [...ingredients];
    final index = ingredientsCopy.indexWhere(
      (element) => element.title.contains(
        ingredient.title,
      ),
    );

    if (index != -1) {
      ingredientsCopy[index].selected = !ingredient.selected;
      ingredients = ingredientsCopy;
      notifyListeners();
    }
  }
}
