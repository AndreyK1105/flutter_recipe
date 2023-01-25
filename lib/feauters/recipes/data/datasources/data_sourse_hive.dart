import 'package:flutter_recipe/feauters/recipes/domain/entities/recipe.dart';
import 'package:hive/hive.dart';

abstract class DataSourseLocalHive {
  Future<List<Recipe>> getRecipe();
  Future<void> saveRecipe(List<Recipe> recipes);
}

class DataSourseLocalHiveImpl implements DataSourseLocalHive {
  @override
  Future<List<Recipe>> getRecipe() async {
    List<Recipe> recipes = [];
    var box = Hive.box<Recipe>('Recipes');
    int boxLenght = box.length;
    for (int i = 0; i < boxLenght; i++) {
      Recipe recipe = box.getAt(i) as Recipe;
      recipes.add(recipe);
    }

    return recipes;
  }

  @override
  Future<void> saveRecipe(List<Recipe> recipes) {
    // print('save in Hive');
    var box = Hive.box<Recipe>('Recipes');
    box.clear();

    return box.addAll(recipes);
  }
}
