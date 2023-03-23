import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../bloc/comments_widget_bloc/comments_widget_cubit.dart';

class CreatComment extends StatefulWidget {
  final String recipeId;
  final String userId;

  const CreatComment({required this.recipeId, required this.userId, super.key});

  @override
  State<CreatComment> createState() => _CreatCommentState();
}

class _CreatCommentState extends State<CreatComment> {
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool submitText = false;
  var file;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      decoration: BoxDecoration(
          border: Border.all(
              width: 2,
              color: const Color(0xFF165932),
              style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(5)),
      child: Row(children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(left: 14),
          child: TextField(
            textInputAction: TextInputAction.go,
            controller: _textEditingController,
            focusNode: _focusNode,
            cursorColor: Colors.blue,
            onSubmitted: (value) => {
              addComment(value, file),
            },
            onEditingComplete: () {
              _focusNode.nextFocus();
            },
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
                  source: ImageSource.camera,
                );

                file = File(xFile!.path);

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
    );
  }

  addComment(String textMessage, var file) {
    String filePath = '';
    if (file != null) {
      filePath = file.path;
    }

    context.read<CommentsWidgetCubit>().addComment(
          widget.recipeId,
          widget.userId,
          _textEditingController.text,
          filePath,
        );
    _textEditingController.clear();
  }
}
