import 'package:flutter_recipe/feauters/recipes/data/datasources/data_source_strukt.dart';
import 'package:flutter_recipe/feauters/recipes/data/datasources/data_sourse_hive.dart';
import 'package:flutter_recipe/feauters/recipes/domain/entities/recipe.dart';
import 'package:flutter_recipe/feauters/recipes/domain/repository/recipe_repository.dart';

class RecipeRepositoryLocal implements RecipeRepository{
 // DataSourseStrukt dataSourseStrukt;
  DataSourseLocalHive dataSourseLocalHive;

  RecipeRepositoryLocal({required this.dataSourseLocalHive}){}
 @override
  Future<List<Recipe>> getRecipe()async {
   return dataSourseLocalHive.getRecipe();
      }
}