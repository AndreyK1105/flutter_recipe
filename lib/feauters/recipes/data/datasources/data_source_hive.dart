import 'package:flutter_recipe/feauters/recipes/domain/entities/recipe.dart';
import 'package:hive/hive.dart';

abstract class DataSourceLocalHive {
  Future<void> initHive();
  Future<List<Recipe>> getRecipe();
  Future<void> saveRecipe(List<Recipe> recipes);
}

class DataSourceLocalHiveImpl implements DataSourceLocalHive {
  // DataSourceLocalHiveImpl() {
  //   init();
  // }

  @override
  Future<void> initHive() async {
    //final res = await Hive.openBox<Recipe>('Recipes1');
    print('init');
  }

  @override
  Future<List<Recipe>> getRecipe() async {
    List<Recipe> recipes = [];
    print('get hive');
    var box = Hive.box<Recipe>('Recipes');
    int boxLenght = box.length;
    for (int i = 0; i < boxLenght; i++) {
      Recipe recipe = box.getAt(i) as Recipe;
      recipes.add(recipe);
    }

    return recipes;
  }

  @override
  Future<void> saveRecipe(List<Recipe> recipes) async {
    print('save in Hive ${recipes.first.name}');
    //  await Hive.openBox<Recipe>('Recipes');
    var box = Hive.box<Recipe>('Recipes');
    await box.clear();

    await box.addAll(recipes);
  }
}
