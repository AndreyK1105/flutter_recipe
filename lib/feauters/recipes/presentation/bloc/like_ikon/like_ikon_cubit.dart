import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repository/recipe_repository_impl.dart';
import '../../../domain/entities/recipe.dart';
import 'like_ikon_state.dart';

class LikeIkonCubit extends Cubit<LikeIkonState> {
  RecipeRepositoryImpl recipeRepositoryImpl;
  LikeIkonCubit({required this.recipeRepositoryImpl})
      : super(LikeIkonStateEmptry());
  loadLikes(List<Recipe> recipes, String userId) async {
    emit(LikeIkonStateLoading());
    Map<String, bool> likes = {};
    for (int i = 0; i < recipes.length; i++) {
      List<String> listRecipesID =
          await recipeRepositoryImpl.getLikeUsersId(recipes[i].id);

      for (int j = 0; j < listRecipesID.length; j++) {
        if (listRecipesID[j] == userId) {
          likes[recipes[i].id] = true;
        }
      }
    }
    // print('LikeCubit--- emit Loaded${likes.length}');
    emit(LikeIkonStatteLoaded(likes: likes));
  }
}
