import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_recipe/feauters/recipes/domain/entities/recipe.dart';

import '../../../data/repository/recipe_repository_impl.dart';
import '../../../domain/entities/user.dart';
import 'comments_widget_state.dart';

class CommentsWidgetCubit extends Cubit<CommentsWidgetState> {
  RecipeRepositoryImpl recipeRepositoryImpl;

  CommentsWidgetCubit({required this.recipeRepositoryImpl})
      : super(CommentsWidgetStateEmpty());

  Future<List<CommentsList>> getComments(String recipeId) async {
    //  List<CommentsList> commentsList = [];
    emit(CommentsWidgetStateLoading());
    List<CommentsList> commenstList =
        await recipeRepositoryImpl.getComments(recipeId);

    emit(CommentsWidgetStateLoaded(
        commentsList: commenstList, recipeId: recipeId));
    return commenstList;
  }

  Future<void> addComment(
      String recipeId, String userId, String comment, String img) async {
    await recipeRepositoryImpl.addComment(recipeId, userId, comment, img);
    getComments(recipeId);
  }

  void stateEmpty() {
    emit(CommentsWidgetStateEmpty());
  }
}

class CommentsList {
  String userName;
  String userImg;
  String comment;
  String imgComment;
  String data = '';
  CommentsList(
      {required this.userName,
      required this.userImg,
      required this.comment,
      required this.imgComment});
}
