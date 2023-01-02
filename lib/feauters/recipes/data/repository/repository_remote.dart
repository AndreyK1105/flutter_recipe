import 'package:flutter_recipe/feauters/recipes/data/datasources/data_sours_remote.dart';
import 'package:flutter_recipe/feauters/recipes/domain/entities/recipe.dart';
import 'package:flutter_recipe/feauters/recipes/domain/repository/recipe_repository.dart';

class RecipeRepositoryRemote implements RecipeRepository{
  DataSourseRemote dataSourseRemote;

  RecipeRepositoryRemote({required this.dataSourseRemote});

  @override
  Future<List<Recipe>> getRecipe() async{

   return await dataSourseRemote.getRecipeRemote();
   // throw UnimplementedError();
  }
 
  
}