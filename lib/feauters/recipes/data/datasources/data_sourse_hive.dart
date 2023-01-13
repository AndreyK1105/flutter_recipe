import 'package:flutter_recipe/feauters/recipes/domain/entities/recipe.dart';
import 'package:hive/hive.dart';

abstract class DataSourseLocalHive {
  Future< List<Recipe>> getRecipe();
}

class DataSourseLocalHiveImpl implements DataSourseLocalHive{
  @override
  Future<List<Recipe>> getRecipe() async{

   List <Recipe> recipes=[];
   var box = Hive.box<Recipe>('Recipes');
   int boxLenght= box.length;
   for(int i=0; i<boxLenght; i++){
    Recipe recipe=box.getAt(i) as Recipe;
    recipes.add(recipe);
   }

   return recipes;
  }


}