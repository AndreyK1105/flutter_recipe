import 'package:flutter_recipe/feauters/recipes/presentation/bloc/comments_widget_bloc/comments_widget_cubit.dart';

import '../../domain/entities/recipe.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

import '../../domain/entities/user.dart';

abstract class DataSourceRemote {
  Future<List<Recipe>> getRecipeRemote();
  Future<int> getAgregatelikes(String recipeId);
  Future<List<String>> getLikeUsersId(String recipeId);
  Future<int> changeLikeCurentUser(String recipeId, String curentUserId);
  Future<void> addComment(
      String recipeId, String userId, String comment, String img);
  Future<User> getUser(String userId);
  Future<List<CommentsList>> getComments(String recipeId);
  Future<Recipe> getRecipe(String recipeId);
//   Future<void> addImage(String pathFile, )
}

class DataSourceRemoteImpl implements DataSourceRemote {
  final dio = Dio();

  @override
  Future<List<Recipe>> getRecipeRemote() async {
    List<Recipe> list = [];

    var searchMenuItems =
        await dio.get('http://80.87.198.104:3001/api/recipes/');

    if (searchMenuItems.statusCode == 200) {
      final recipes = searchMenuItems.data;

      list = (recipes['data'] as List)
          .map((recipe) => Recipe.fromJson(recipe))
          .toList();
      print('list.length${list.length}');

      return list;
    } else {
      print('searchMenuItems.statusCode=${searchMenuItems.statusCode}');
      return throw UnimplementedError();
    }
    ;
  }

  @override
  Future<int> getAgregatelikes(String recipeId) async {
    Recipe recipe = await getRecipe(recipeId);
    int aggregateLikes = recipe.aggregateLikes;
    List<String> likeUsersId = recipe.likeUsersId;
    print('name=${recipe.name}');
    print('aggregateLikes=$aggregateLikes');
    print('likeUsersId=${likeUsersId.length}');
    return aggregateLikes;
  }

  @override
  Future<List<String>> getLikeUsersId(String recipeId) async {
    Recipe recipe = await getRecipe(recipeId);
    List<String> likeUsersId = recipe.likeUsersId;

    return likeUsersId;

    throw UnimplementedError();
  }

  @override
  Future<int> changeLikeCurentUser(String recipeId, String curentUserId) async {
    bool noFavorite = true;
    List<String> likeUsersId = await getLikeUsersId(recipeId);
    User user = await getUser(curentUserId);
    List<String> listLikeRecipes = user.likeRecipeId;

    for (int i = 0; i < likeUsersId.length; i++) {
      if (likeUsersId[i] == curentUserId) {
        likeUsersId.remove(curentUserId);
        noFavorite = false;
      }
    }
    for (int i = 0; i < listLikeRecipes.length; i++) {
      if (listLikeRecipes[i] == recipeId) {
        listLikeRecipes.remove(recipeId);
      }
    }

    if (noFavorite) {
      likeUsersId.add(curentUserId);
      listLikeRecipes.add(recipeId);
    }

    Map<String, dynamic> json = {
      'likeUsersId': [
        for (int j = 0; j < likeUsersId.length; j++) {'userId': likeUsersId[j]}
      ]
    };

    Map<String, dynamic> jsonUserLikeRecipes = {
      'likeRecipeId': [
        for (int j = 0; j < listLikeRecipes.length; j++)
          {'recipeId': listLikeRecipes[j]}
      ]
    };
    print(json);
    final respopnse = await dio
        .put('http://80.87.198.104:3001/api/recipes/$recipeId/', data: json);
    if (respopnse.statusCode == 200) {
      final responseUser = await dio.put(
          'http://80.87.198.104:3001/api/users/$curentUserId/',
          data: jsonUserLikeRecipes);
      if (responseUser.statusCode == 200) {
        return likeUsersId.length;
      }

      return likeUsersId.length;
    } else {
      return throw UnimplementedError();
    }
  }

  @override
  Future<void> addComment(
      String recipeId, String userId, String comment, String img) async {
    String imgServ = '';

    if (img != '') {
      String extension = '.${img.split('.').last}';
      print('extension img=$extension');
      String filename =
          (DateTime.now().millisecondsSinceEpoch.toString()) + extension;
      final formData = FormData.fromMap({
        'filedata': await MultipartFile.fromFile(img, filename: filename),
      });
      var response =
          await dio.post('http://80.87.198.104:3001/upload', data: formData);
      if (response.statusCode == 200) {
        imgServ = 'http://80.87.198.104:3001/file/$filename';
      }
    }

    Recipe recipe = await getRecipe(recipeId);
    print('recipe id= ${recipe.id}');
    Comment newComment = Comment(user: userId, comment: comment, img: imgServ);
    print('newComment.comment-${newComment.comment}');
    List<Comment> comments = recipe.comments;
    print('comments.lenght-${comments.length}');
    comments.add(newComment);
    print('comments.lenght-${comments.length}');
    //String js = jsonEncode(comments);
    List<Map<String, dynamic>> listMap = [];
    for (int i = 0; i < comments.length; i++) {
      listMap.add((Comment.toJson(comments[i])));
    }
    print('js=$listMap');
    Map<String, dynamic> json = {'comments': listMap};

    print('json=$json');

    var respopnse = await dio
        .put('http://80.87.198.104:3001/api/recipes/$recipeId/', data: json);

    if (respopnse.statusCode == 200) {
    } else {
      throw UnimplementedError();
    }
  }

  @override
  Future<User> getUser(String userId) async {
    final response =
        await dio.get('http://80.87.198.104:3001/api/users/$userId/');
    if (response.statusCode == 200) {
      User user = User.fromJson(response.data['data']);

      return user;
    }

    throw UnimplementedError();
  }

  @override
  Future<List<CommentsList>> getComments(String recipeId) async {
    Recipe recipe = await getRecipe(recipeId);
    print(recipeId);
    List<CommentsList> commentsList = [];
    List<Comment> comments = recipe.comments;

    for (int i = 0; i < comments.length; i++) {
      User user = await getUser(comments[i].user);

      CommentsList comment;
      commentsList.add(comment = CommentsList(
          userName: user.name,
          userImg: user.avatar,
          comment: comments[i].comment,
          imgComment: comments[i].img));
    }

    return commentsList;
  }

  @override
  Future<Recipe> getRecipe(String recipeId) async {
    Recipe recipe;
    var respopnse =
        await dio.get('http://80.87.198.104:3001/api/recipes/$recipeId/');
    if (respopnse.statusCode == 200) {
      recipe = Recipe.fromJson(respopnse.data['data']);
      return recipe;
    } else {
      throw UnimplementedError();
    }
  }
}
