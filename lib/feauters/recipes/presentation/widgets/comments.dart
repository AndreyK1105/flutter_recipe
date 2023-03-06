import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_recipe/feauters/recipes/presentation/bloc/comments_widget_bloc/comments_widget_cubit.dart';
import 'package:flutter_recipe/feauters/recipes/presentation/bloc/comments_widget_bloc/comments_widget_state.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/entities/recipe.dart';

class CommentsWidget extends StatefulWidget {
  List<Comment> comments;
  String userId;
  String recipeId;
  CommentsWidget(
      {required this.comments,
      required this.userId,
      required this.recipeId,
      super.key});

  @override
  State<CommentsWidget> createState() => _CommentsWidgetState();
}

class _CommentsWidgetState extends State<CommentsWidget> {
  late final TextEditingController _textEditingController =
      TextEditingController();
  List<CommentsList> commentsList = [];
  File? file;
  bool submitText = false;
  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(() {
      setState(() {
        submitText = _textEditingController.text.isNotEmpty;
      });
    });
  }

  @override
  void didChangeDependencies() async {
    String recipeId = '';
    var state = context.read<CommentsWidgetCubit>().state;
    if (state is CommentsWidgetStateLoaded) {
      recipeId = state.recipeId;
    }

    if (state is CommentsWidgetStateEmpty) {
      print('1===$state');
      await context.read<CommentsWidgetCubit>().getComments(widget.recipeId);
    } else if (state is CommentsWidgetStateLoading) {
      return;
    } else if (recipeId != widget.recipeId) {
      print('2===$state');
      await context.read<CommentsWidgetCubit>().getComments(widget.recipeId);
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
    //context.read<CommentsWidgetCubit>().stateEmpty();
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    final state = context.watch<CommentsWidgetCubit>().state;
    if (state is CommentsWidgetStateLoaded) {
      commentsList = state.commentsList;
      // print('commentsList.length=${commentsList.length}');
    }
    return state is CommentsWidgetStateLoading
        ? const Center(
            child: CircularProgressIndicator(
            color: Colors.black,
          ))
        : Column(children: [
            Column(
              children: List<Widget>.generate(
                  //shrinkWrap: true,

                  commentsList.length,
                  //itemBuilder: (context, int index) {
                  // print('img user=${commentsList[index].userImg}');
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

                          //commentsList[index].userImg,
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
                                        child: Image.network(
                                          commentsList[index].imgComment,
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
            Container(
              //width: 400,
              height: 72,
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 2,
                      color: const Color(0xFF165932),
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 14),
                      child: TextField(
                        controller: _textEditingController,
                        cursorColor: Colors.blue,
                        onSubmitted: (value) => {},
                        decoration: const InputDecoration(
                            hintStyle: TextStyle(color: Colors.black),
                            hintText: 'оставить коментарий'),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                      ),
                    )),
                    Padding(
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      child: InkWell(
                          splashColor: Colors.amber,
                          onTap: () async {
                            final ImagePicker _picker = ImagePicker();
                            final XFile? xFile = await _picker.pickImage(
                              source: ImageSource.gallery,
                            );
                            var mimeType = xFile!.mimeType;
                            // String path = xFile!.path;
                            // String name = xFile!.path;
                            file = File(xFile.path);

                            final Uint8List bytes = await xFile.readAsBytes();
                            //var images = Image.memory(bytes).image;
                            if (file != null) {}
                            setState(() {});
                          },
                          child: file != null
                              ? Image.file(
                                  file!,
                                  width: 100,
                                  height: 100,
                                )
                              : Image.asset(
                                  'assets/icons_png/icons8-изображение-96 1.png')),
                    ),
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: submitText
                        ? () {
                            String filePath = '';
                            if (file != null) filePath = file!.path;
                            context.read<CommentsWidgetCubit>().addComment(
                                  widget.recipeId,
                                  widget.userId,
                                  _textEditingController.text,
                                  filePath,
                                );
                            _textEditingController.clear();
                            file = null;
                          }
                        : null,
                    child: Text('Add Comment'),
                    style: style,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _textEditingController.clear();
                        file = null;
                      });
                    },
                    child: Text('Cancel'),
                    style: style,
                  ),
                ],
              ),
            )
          ]);
  }
}
