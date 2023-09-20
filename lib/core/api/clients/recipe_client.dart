import 'dart:convert';

import 'package:tech_task/core/api/api.dart';

class RecipeClient {
  final DioClient _client;
  RecipeClient({
    required DioClient client,
  }) : _client = client;

  Future<List<IngredientModel>> getIngredients() async {
    final req = await _client.get('/ingredients');
    final res = _client.errorInterceptor(req);
    final List<dynamic> jsonList = json.decode(res.data ?? '');
    return jsonList
        .map(
          (it) => IngredientModel.fromMap(it),
        )
        .toList();
  }

  Future<List<Recipiemodel>> getRecipie({
    required List<String> selectedIngredients,
  }) async {
    final req = await _client.get('/recipes', queryParameters: {
      "ingredients": selectedIngredients.join(','),
    });
    final res = _client.errorInterceptor(req);
    final List<dynamic> jsonList = json.decode(res.data ?? '');
    return jsonList
        .map(
          (it) => Recipiemodel.fromMap(it),
        )
        .toList();
  }
}
