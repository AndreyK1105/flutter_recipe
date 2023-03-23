import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_recipe/feauters/recipes/presentation/bloc/comments_widget_bloc/comments_widget_cubit.dart';
import 'package:flutter_recipe/feauters/recipes/presentation/bloc/comments_widget_bloc/comments_widget_state.dart';

import '../../domain/entities/recipe.dart';
import 'creat_comment.dart';

class CommentsWidget extends StatelessWidget {
  final List<Comment> comments;
  final String userId;
  final String recipeId;
  CommentsWidget(
      {required this.comments,
      required this.userId,
      required this.recipeId,
      super.key});

  List<CommentsList> commentsList = [];
  File? file;

  @override
  Widget build(BuildContext context) {
    context.read<CommentsWidgetCubit>().getComments(recipeId);

    return BlocConsumer<CommentsWidgetCubit, CommentsWidgetState>(
        listener: (context, state) async {
      if (state is CommentsWidgetStateLoaded) {
        commentsList = state.commentsList;
      }
    }, builder: (context, state) {
      return state is CommentsWidgetStateLoading ||
              state is CommentsWidgetStateEmpty
          ? const Center(
              child: CircularProgressIndicator(
              color: Color.fromARGB(255, 8, 148, 26),
            ))
          : Column(children: [
              Column(
                children: List<Widget>.generate(
                    commentsList.length,
                    (int index) => Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: CircleAvatar(
                                radius: 30,
                                child: ClipOval(
                                  child: Image.network(
                                      commentsList[index].userImg,
                                      width: 60,
                                      fit: BoxFit.fill),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Column(
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          commentsList[index].userName,
                                          style: const TextStyle(
                                              color: Color.fromRGBO(
                                                  46, 204, 113, 1)),
                                        ),
                                        const Text('data')
                                      ]),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(commentsList[index].comment),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  commentsList[index].imgComment != ''
                                      ? SizedBox(
                                          width: 250,
                                          //height: 315,
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                commentsList[index].imgComment,
                                            placeholder: (context, url) =>
                                                const Padding(
                                              padding: EdgeInsets.all(40.0),
                                              child: Center(
                                                child: SizedBox(
                                                  width: 60,
                                                  height: 60,
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Color.fromARGB(
                                                        255, 8, 117, 26),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                            fit: BoxFit.cover,

                                            // fit: BoxFit.contain,
                                          ),
                                        )
                                      : const SizedBox(
                                          height: 5,
                                        ),
                                ],
                              ),
                            ),
                          ],
                        )),
              ),
              const SizedBox(
                height: 20,
              ),
              CreatComment(
                recipeId: recipeId,
                userId: userId,
              ),
            ]);
    });
  }
}
