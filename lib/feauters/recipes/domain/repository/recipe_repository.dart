import 'package:flutter_recipe/feauters/recipes/domain/entities/recipe.dart';

abstract class RecipeRepository{
  Future <List <Recipe>> getRecipe();
}