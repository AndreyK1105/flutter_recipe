import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_recipe/feauters/recipes/domain/entities/recipe.dart';
import 'package:flutter_recipe/feauters/recipes/domain/repository/recipe_repository.dart';
import 'package:flutter_recipe/feauters/recipes/presentation/bloc/list_recipe_cubit/list_recipe_state.dart';
import 'package:flutter_network_connectivity/flutter_network_connectivity.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../data/repository/recipe_repository_impl.dart';

class ListRecipeCubit extends Cubit<ListRecipeState> {
  //RecipeRepository recipeRepository;
  RecipeRepositoryImpl recipeRepositoryImpl;
  // FlutterNetworkConnectivity flutterNetworkConnectivity;

  ListRecipeCubit({required this.recipeRepositoryImpl})
      : super(ListRecipeEmpty());

//  void init() async {
//   flutterNetworkConnectivity.getInternetAvailabilityStream().listen((isInternetAvailable) {
//   // do something
// });
//     await flutterNetworkConnectivity.registerAvailabilityListener();
//   }
  void getRecipe() async {
    // await flutterNetworkConnectivity.registerAvailabilityListener();

    if (state is ListRecipeLoading) return;
    emit(ListRecipeLoading());
    //print('2state =$state');
    //bool isNetwork = await InternetConnectionChecker().hasConnection;
    // isNetwork=true;

    final recipes = await recipeRepositoryImpl.getRecipe();
    emit(ListRecipeLoaded(list: recipes));
  }
}
