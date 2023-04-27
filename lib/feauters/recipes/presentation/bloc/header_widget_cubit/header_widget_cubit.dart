import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repository/recipe_repository_impl.dart';
import 'header_widget_state.dart';

class HeaderWidgetCubit extends Cubit<HeaderWidgetState> {
  RecipeRepositoryImpl recipeRepositoryImpl;

  //String curentUserId = '111';

  HeaderWidgetCubit({required this.recipeRepositoryImpl})
      : super(HeaderWidgetStateEmpty());

  // void getAgregatelikes(String recipeId) async {
  //   int aggregateLikes = await recipeRepositoryImpl.getAgregatelikes(recipeId);
  //   emit(HeaderWidgetStateLike(aggregateLikes: aggregateLikes));
  // }

  void getLikeUsersId(String recipeId, String userId) async {
    int aggregateLikes;
    bool isMyLike = false;
    List<String> listRecipesID =
        await recipeRepositoryImpl.getLikeUsersId(recipeId);

    isMyLike = false;
    for (int i = 0; i < listRecipesID.length; i++) {
      if (listRecipesID[i] == userId) {
        isMyLike = true;
      }
    }
    aggregateLikes = listRecipesID.length;
    //print('getUsersId listRecipeId=${listRecipesID.length}');
    if (isMyLike) {
      emit(HeaderWidgetStateLike(aggregateLikes: aggregateLikes));
    } else {
      emit(HeaderWidgetStateUnLike(aggregateLikes: aggregateLikes));
    }
  }

  Future<void> changeFavorite(String recipeId, String userId) async {
    emit(HeaderWidgetStateLoading());
    await recipeRepositoryImpl.changeLikeCurentUser(recipeId, userId);

    getLikeUsersId(recipeId, userId);
  }
}
