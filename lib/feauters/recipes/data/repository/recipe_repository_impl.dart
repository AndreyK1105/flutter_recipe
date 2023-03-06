import 'package:flutter_recipe/core/network_cheker.dart';
import 'package:flutter_recipe/feauters/recipes/data/datasources/data_sourse_hive.dart';
import 'package:flutter_recipe/feauters/recipes/domain/entities/recipe.dart';
import 'package:flutter_recipe/feauters/recipes/domain/entities/user.dart';
import 'package:flutter_recipe/feauters/recipes/domain/repository/recipe_repository.dart';
import 'package:flutter_recipe/feauters/recipes/presentation/bloc/comments_widget_bloc/comments_widget_cubit.dart';

import '../datasources/data_source_file.dart';
import '../datasources/data_source_remote.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  DataSourceRemote dataSourseRemote;
  DataSourceLocalHive dataSourseLocalHive;
  DataSourseFile dataSourseFile;
  NetworkCheker networkCheker = NetworkCheker();

  RecipeRepositoryImpl(
      {required this.dataSourseRemote,
      required this.dataSourseLocalHive,
      required this.dataSourseFile});

  @override
  Future<List<Recipe>> getRecipes() async {
    List<Recipe> recipes = [];

    recipes = await dataSourseRemote.getRecipeRemote();

    // if (isNetwork) {
    //    recipes = await dataSourseRemote.getRecipeRemote();
    //        await dataSourseLocalHive.saveRecipe(recipes);
    // }  else {
    //   recipes = await dataSourseLocalHive.getRecipe();
    // }

    return recipes;
  }

  @override
  Future<int> getAgregatelikes(String recipeId) async {
    int aggregateLikes = await dataSourseRemote.getAgregatelikes(recipeId);
    return aggregateLikes;
  }

  @override
  Future<List<String>> getLikeUsersId(String recipeId) async {
    List<String> likeUsersId = await dataSourseRemote.getLikeUsersId(recipeId);
    return likeUsersId;
  }

  @override
  Future<int> changeLikeCurentUser(String recipeId, String curentUserId) async {
    int aggregateLikes =
        await dataSourseRemote.changeLikeCurentUser(recipeId, curentUserId);
    return aggregateLikes;
  }

  @override
  Future<void> addComment(
      String recipeId, String userId, String comment, String img) async {
    await dataSourseRemote.addComment(recipeId, userId, comment, img);
  }

  @override
  Future<User> getUser(String userId) async {
    User user = await dataSourseRemote.getUser(userId);
    return user;
  }

  @override
  Future<List<CommentsList>> getComments(String recipeId) async {
    List<CommentsList> commentsList =
        await dataSourseRemote.getComments(recipeId);
    return commentsList;
  }

  @override
  Future<Recipe> getRecipe(String recipeId) async {
    Recipe recipe = await dataSourseRemote.getRecipe(recipeId);
    throw UnimplementedError();
  }
}
