import 'package:flutter_recipe/feauters/recipes/domain/entities/recipe.dart';
import 'package:hive/hive.dart';

abstract class DataSourceLocalHive {
  Future<List<Recipe>> getRecipe();
  Future<void> saveRecipe(List<Recipe> recipes);
}

class DataSourceLocalHiveImpl implements DataSourceLocalHive {
  // DataSourceLocalHiveImpl() {
  //   init();
  // }

  void init() async {
    print('init');
    await Hive.openBox<Recipe>('Recipes1');
  }

  @override
  Future<List<Recipe>> getRecipe() async {
    List<Recipe> recipes = [];
    print('get hive');
    var box = Hive.box<Recipe>('Recipes1');
    int boxLenght = box.length;
    for (int i = 0; i < boxLenght; i++) {
      Recipe recipe = box.getAt(i) as Recipe;
      recipes.add(recipe);
    }

    return recipes;
  }

  @override
  Future<void> saveRecipe(List<Recipe> recipes) {
    print('save in Hive');
    var box = Hive.box<Recipe>('Recipes1');
    box.clear();

    return box.addAll(recipes);
  }
}
