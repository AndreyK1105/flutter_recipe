import 'package:flutter_recipe/feauters/recipes/domain/entities/recipe.dart';

abstract class  ListRecipeState{}

class ListRecipeEmpty extends ListRecipeState{

}

class ListRecipeLoading extends ListRecipeState{

}

class ListRecipeLoaded extends ListRecipeState{
 List <Recipe> list=[];
ListRecipeLoaded({required this.list}){}
}

class ListRecipeError extends ListRecipeState{

}
