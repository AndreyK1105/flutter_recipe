import 'package:flutter_recipe/feauters/recipes/data/datasources/data_source_strukt.dart';
import 'package:flutter_recipe/feauters/recipes/domain/entities/recipe.dart';
import 'package:flutter_recipe/feauters/recipes/domain/repository/recipe_repository.dart';

class RecipeRepositoryLocal implements RecipeRepository{
  DataSourseStrukt dataSourseStrukt;

  RecipeRepositoryLocal({required this.dataSourseStrukt}){}
 @override
  Future<List<Recipe>> getRecipe()async {
   return dataSourseStrukt.getRecipe();
      }
}