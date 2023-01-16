class Recipe {
  String name = '';
  String img = '';
  String time = '';
  List<Ingredient> ingredients = [];
  List<Cook> cook = [];
  Recipe(
      {required this.name,
      required this.img,
      required this.time,
      required this.ingredients,
      required this.cook});

static Recipe fromJson(Map<String, dynamic> json) {
  
  return Recipe(
    name:json['name'] ,
    time: json['time'],
    img: json['img'],
    ingredients:(json['ingredients'] as List).map((ingredient) => Ingredient.fromJson(ingredient)).toList(),
    cook:(json['cook'] as List).map((cook) => Cook.fromJson(cook)).toList(),
     );
}

}

class Ingredient {
  String ingredient = '';
  String volume = '';
  Ingredient({required this.ingredient, required this.volume});

  static Ingredient fromJson (Map<String, dynamic> json){
    return Ingredient(
      ingredient: json['ingredient'], 
      volume:  json['volume']);
  }
}

class Cook {
  String step = '';
  String timeStep = '';
  Cook({required this.step, required this.timeStep});

  static Cook fromJson (Map<String, dynamic> json){
    return Cook(
      step: json['step'], 
      timeStep:  json['timeStep']);
  }
}
