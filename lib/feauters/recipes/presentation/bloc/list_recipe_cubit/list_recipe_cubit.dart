import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_recipe/feauters/recipes/data/repository/repository_local.dart';
import 'package:flutter_recipe/feauters/recipes/domain/entities/recipe.dart';
import 'package:flutter_recipe/feauters/recipes/domain/repository/recipe_repository.dart';
import 'package:flutter_recipe/feauters/recipes/presentation/bloc/list_recipe_cubit/list_recipe_state.dart';
import 'package:flutter_recipe/feauters/recipes/presentation/screens/recipe.dart';

class ListRecipeCubit extends Cubit <ListRecipeState>{
  RecipeRepository recipeRepository;
  ListRecipeCubit ({required this.recipeRepository}): super (ListRecipeEmpty());


  void getRecipe() async{
if(state is ListRecipeLoading) return;
emit(ListRecipeLoading());
try {
Future<List<Recipe>> recipes =  recipeRepository.getRecipe();

recipes.then((value) => emit(ListRecipeLoaded(list: value))) ;
  }catch(err){ emit(ListRecipeError());}
  } 
}