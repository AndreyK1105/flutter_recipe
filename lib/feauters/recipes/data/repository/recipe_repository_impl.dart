import 'package:flutter_recipe/core/network_cheker.dart';
import 'package:flutter_recipe/feauters/recipes/data/datasources/data_sours_remote.dart';
import 'package:flutter_recipe/feauters/recipes/data/datasources/data_sourse_file.dart';
import 'package:flutter_recipe/feauters/recipes/data/datasources/data_sourse_hive.dart';
import 'package:flutter_recipe/feauters/recipes/domain/entities/recipe.dart';
import 'package:flutter_recipe/feauters/recipes/domain/repository/recipe_repository.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  DataSourseRemote dataSourseRemote;
  DataSourseLocalHive dataSourseLocalHive;
  DataSourseFile dataSourseFile;
  NetworkCheker networkCheker = NetworkCheker();

  RecipeRepositoryImpl(
      {required this.dataSourseRemote,
      required this.dataSourseLocalHive,
      required this.dataSourseFile});

  @override
  Future<List<Recipe>> getRecipe() async {
    //bool isNetwork = await networkCheker.isInternetConnection();

    List<Recipe> recipes = [];

    recipes = await dataSourseFile.getRecipe();

    // if (isNetwork) {
    //    recipes = await dataSourseRemote.getRecipeRemote();
    //        await dataSourseLocalHive.saveRecipe(recipes);
    // }  else {
    //   recipes = await dataSourseLocalHive.getRecipe();
    // }

    return recipes;
  }
}
