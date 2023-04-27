import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_recipe/feauters/recipes/presentation/bloc/list_recipe_cubit/list_recipe_state.dart';

import '../../../data/repository/recipe_repository_impl.dart';

class ListRecipeCubit extends Cubit<ListRecipeState> {
  RecipeRepositoryImpl recipeRepositoryImpl;

  final Connectivity _connectivity = Connectivity();

  ListRecipeCubit({required this.recipeRepositoryImpl})
      : super(ListRecipeEmpty());

  void getRecipe() async {
    if (state is ListRecipeLoading) return;
    emit(ListRecipeLoading());

    final statusNet = await connectionStatus();
    if (statusNet == true) {
      final recipes = await recipeRepositoryImpl.getRecipes();
      await recipeRepositoryImpl.dataSourseLocalHive.initHive();
      await recipeRepositoryImpl.dataSourseLocalHive.saveRecipe(recipes);
      
      //  print('recipi in cubit save hive${recipes.length}');
      emit(ListRecipeLoaded(list: recipes));
    } else {
      final recipes =
          await recipeRepositoryImpl.dataSourseLocalHive.getRecipe();

      emit(ListRecipeLoaded(list: recipes));
    }
  }

  Future<bool> connectionStatus() async {
    late ConnectivityResult result;
    bool status;

    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      return false;
    }

    if (result == ConnectivityResult.none) {
      status = false;
    } else
      status = true;
    return status;
  }
}
