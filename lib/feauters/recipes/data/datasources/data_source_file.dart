import 'dart:convert';

import 'package:flutter/services.dart';

import '../../domain/entities/recipe.dart';

class DataSourseFile {
  String pathFile; //'assets/file/recipe.json'

  DataSourseFile({required this.pathFile});

  Future<List<Recipe>> getRecipe() async {
    String content = await rootBundle.loadString(pathFile);
    //print(content.length);

    final jsonDecode = json.decode(content);
    List<Recipe> recipes =
        (jsonDecode['recipe'] as List).map((e) => Recipe.fromJson(e)).toList();

    return recipes;
  }
}
