class Recipe {
  String name='';
  String img='';
  String time='';
  List <Ingredient> ingredients=[];
  List<Cook> cook=[];
  Recipe({required this.name, required this.img, required this.time, 
  required this.ingredients, required this.cook}){}
}

class Ingredient {

  String ingredient ='';
  String volume ='';
Ingredient({required this.ingredient, required this.volume});
}
 
class Cook {
  String step='';
  String timeStep='';
  Cook({required this.step, required this.timeStep}){}
}