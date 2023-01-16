import 'dart:convert';
import 'package:flutter/services.dart';

import '../recipe.dart';

class DataSourseStrukt {
  Future<List<Recipe>> getRecipe() async {
    List<Recipe> recipes = [];

    String content = await rootBundle.loadString('assets/file/recipe.json');
    print(content.length);

    final jsonDecode = json.decode(content);
    recipes =
        (jsonDecode['recipe'] as List).map((e) => Recipe.fromJson(e)).toList();

    return recipes;
  }
}
