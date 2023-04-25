import 'comments_widget_cubit.dart';

abstract class CommentsWidgetState {}

class CommentsWidgetStateEmpty extends CommentsWidgetState {}

class CommentsWidgetStateLoaded extends CommentsWidgetState {
  List<CommentsList> commentsList;
  String recipeId;
  CommentsWidgetStateLoaded(
      {required this.commentsList, required this.recipeId});
}

class CommentsWidgetStateLoading extends CommentsWidgetState {}
