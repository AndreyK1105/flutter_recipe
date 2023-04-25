import 'package:flutter_recipe/feauters/recipes/domain/entities/recipe.dart';

import '../../presentation/bloc/comments_widget_bloc/comments_widget_cubit.dart';
import '../entities/user.dart';

abstract class RecipeRepository {
  Future<List<Recipe>> getRecipes();
  Future<Recipe> getRecipe(String recipeId);
  Future<int> getAgregatelikes(String recipeId);
  Future<List<String>> getLikeUsersId(String recipeId);
  Future<int> changeLikeCurentUser(String recipeId, String curentUserId);
  Future<void> addComment(
      String recipeId, String userId, String comment, String img);
  Future<User> getUser(String userId);
  Future<List<CommentsList>> getComments(String recipeId);
  // Future <void> saveRecipe(List<Recipe> recipes);
}
