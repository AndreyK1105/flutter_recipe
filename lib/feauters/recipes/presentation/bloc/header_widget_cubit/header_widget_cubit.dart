import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repository/recipe_repository_impl.dart';
import 'header_widget_state.dart';

class HeaderWidgetCubit extends Cubit<HeaderWidgetState> {
  RecipeRepositoryImpl recipeRepositoryImpl;

  //String curentUserId = '111';
  bool isMyLike = false;
  HeaderWidgetCubit({required this.recipeRepositoryImpl})
      : super(HeaderWidgetStateEmpty());

  // void getAgregatelikes(String recipeId) async {
  //   int aggregateLikes = await recipeRepositoryImpl.getAgregatelikes(recipeId);
  //   emit(HeaderWidgetStateLike(aggregateLikes: aggregateLikes));
  // }

  void getLikeUsersId(String recipeId, String userId) async {
    int aggregateLikes;
    List<String> listRecipesID =
        await recipeRepositoryImpl.getLikeUsersId(recipeId);
    // int aggregateLikes = await recipeRepositoryImpl.getAgregatelikes(recipeId);
    print('object');
    isMyLike = false;
    for (int i = 0; i < listRecipesID.length; i++) {
      if (listRecipesID[i] == userId) {
        isMyLike = true;

        // return;
      }
    }
    aggregateLikes = listRecipesID.length;
    print('getUsersId listRecipeId=${listRecipesID.length}');
    if (isMyLike) {
      emit(HeaderWidgetStateLike(aggregateLikes: aggregateLikes));
    } else {
      emit(HeaderWidgetStateUnLike(aggregateLikes: aggregateLikes));
    }
  }

  void ChangeFavorite(String recipeId, String userId) async {
    int aggregateLikes =
        await recipeRepositoryImpl.changeLikeCurentUser(recipeId, userId);

    getLikeUsersId(recipeId, userId);
  }
}
