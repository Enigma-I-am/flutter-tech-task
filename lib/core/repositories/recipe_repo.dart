import 'package:dio/dio.dart';
import 'package:tech_task/core/api/api.dart';
import 'package:tech_task/core/result/result.dart';
import 'package:dartx/dartx.dart';


class RecipeRepository {
  final RecipeClient _recipieClient;
  RecipeRepository({
    required RecipeClient recipieClient,
  }) : _recipieClient = recipieClient;

  Future<Result<List<IngredientModel>, RequestFailure>> getIngredients() async {
    try {
      final res = await _recipieClient.getIngredients();
      return SuccessResult(data: res);
    } catch (e) {
      if (e is RequestFailure) {
        return ErrorResult(error: e);
      }

      if (e is DioException) {
        if (e.response != null &&
            e.response?.data.toString().isNotNullOrEmpty == true) {
          return ErrorResult(error: RequestFailure.fromJson(e.response!.data));
        }
        return ErrorResult(error: RequestFailure.createUnknownError(e));
      }

      return ErrorResult(error: RequestFailure.createUnknownError(e));
    }
  }

  Future<Result<List<Recipiemodel>, RequestFailure>> getRecipies({
    required List<String> selectedIngredients,
  }) async {
    try {
      final res = await _recipieClient.getRecipie(
        selectedIngredients: selectedIngredients,
      );
      return SuccessResult(data: res);
    } catch (e) {
      if (e is RequestFailure) {
        return ErrorResult(error: e);
      }

      if (e is DioException) {
        if (e.response != null &&
            e.response?.data.toString().isNotNullOrEmpty == true) {
          return ErrorResult(error: RequestFailure.fromJson(e.response!.data));
        }
        return ErrorResult(error: RequestFailure.createUnknownError(e));
      }

      return ErrorResult(error: RequestFailure.createUnknownError(e));
    }
  }
}
