import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:tech_task/core/core.dart';

import 'recipe_repo_test.mocks.dart';

@GenerateMocks([RecipeRepository])
void main() {
  group('RecipeRepository', () {
    final recipeRepo = MockRecipeRepository();

    final expectedIngredients = [
      IngredientModel(title: 'Water', useBy: '2023-09-27'),
      IngredientModel(title: 'Salt', useBy: '2023-09-30'),
    ];

    final expectedRecipes = [
      Recipiemodel(title: 'Spaghetti', ingredients: ['Water', 'Salt']),
      Recipiemodel(title: 'Pizza', ingredients: ['Water', 'Salt', 'Flour']),
    ];

    test(
        'getIngredients should return a SuccessResult when the request is successful',
        () async {
      when(recipeRepo.getIngredients()).thenAnswer(
        (_) async => SuccessResult(
          data: expectedIngredients,
        ),
      );

      final ingredients = await recipeRepo.getIngredients();
      ingredients.match(
          onSuccess: (r) => expect(r, isNotNull), onError: (err) => null);
    });

    test(
        'getIngredients should return a ErrorResult when the request is unsuccessful',
        () async {
      // Arrange
      when(recipeRepo.getIngredients()).thenAnswer(
        (_) async => const ErrorResult(
          error: RequestFailure(message: 'Something went wrong'),
        ),
      );

      // Act
      final result = await recipeRepo.getIngredients();

      result.match(
        onError: (err) => expect(err, isA<RequestFailure>()),
        onSuccess: (r) => null,
      );
    });

    test(
        'getRecipies should return a SuccessResult when the request is successful',
        () async {
      // Arrange

      when(recipeRepo.getRecipies(selectedIngredients: ['Water', 'Salt']))
          .thenAnswer((_) async => SuccessResult(data: expectedRecipes));

      // Act
      final result =
          await recipeRepo.getRecipies(selectedIngredients: ['Water', 'Salt']);

      result.match(
        onError: (error) => null,
        onSuccess: (data) => expect(data, isNotNull),
      );
    });

    test(
        'getRecipies should return a ErrorResult when the request is unsuccessful',
        () async {
      // Arrange
      when(recipeRepo.getRecipies(selectedIngredients: ['Water', 'Salt']))
          .thenAnswer(
        (_) async => const ErrorResult(
          error: RequestFailure(message: 'Something went wrong'),
        ),
      );

      // Act
      final result =
          await recipeRepo.getRecipies(selectedIngredients: ['Water', 'Salt']);

      result.match(
        onError: (error) => expect(error, isA<RequestFailure>()),
        onSuccess: (data) => null,
      );
    });
  });
}
