import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tech_task/core/core.dart';

final dioProvider = Provider<Dio>(
  (_) => Dio(),
);

final authDioClientProvider = Provider<DioClient>(
  (ref) {
    final dio = ref.watch(dioProvider);
    return DioClient(dio);
  },
);

final recipeClientProvider = Provider<RecipeClient>(
  (ref) {
    final client = ref.watch(authDioClientProvider);
    return RecipeClient(client: client);
  },
);

final recipeRepositoryProvider = Provider<RecipeRepository>(
  (ref) {
    final recipieClient = ref.watch(recipeClientProvider);
    return RecipeRepository(recipieClient: recipieClient);
  },
);

final loaderVmProvider = ChangeNotifierProvider<LoaderVM>(
  (_) => LoaderVM(),
);

final recipeVMProvider = ChangeNotifierProvider<RecipeVM>(
  (ref) {
    final recipieRepository = ref.watch(recipeRepositoryProvider);
    return RecipeVM(ref, recipieRepository: recipieRepository);
  },
);
