import 'package:hive/hive.dart';
part 'recipe.g.dart';

@HiveType(typeId: 0)
class Recipe {
  @HiveField(0)
  String name = '';
  @HiveField(1)
  String img = '';
  @HiveField(2)
  String time = '';
  @HiveField(3)
  List<Ingredient> ingredients = [];
  @HiveField(4)
  List<Cook> cook = [];
  Recipe(
      {required this.name,
      required this.img,
      required this.time,
      required this.ingredients,
      required this.cook});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    // print('json[image]=${json['image']}');
    return Recipe(
        name: (json['title'] != null)
            ? (json['title'] as String)
            : json['name'] as String,
        // if(json['image']==null) {img: ''} else {img: json['image']as String, } ;
        img: (json['img'] != null) ? (json['img'] as String) : "",
        time: (json['time'] != null) ? (json['time'] as String) : "",
        ingredients: (json['ingredients'] != null)
            ? ((json['ingredients'] as List)
                .map((e) => Ingredient.fromJson(e))
                .toList())
            : [],
        cook: (json['cook'] != null)
            ? ((json['cook'] as List).map((e) => Cook.fromJson(e)).toList())
            : []);
  }
}

/*
{type: menuItem, menuItems: [{id: 419357, title: Burger Sliders, image: https://images.spoonacular.com/file/wximages/419357-312x231.png, imageType: png, restaurantChain: Hooters, servingSize: null, readableServingSize: null, servings: {number: 1, size: null, unit: null}}, 
{id: 424571, title: Bacon King Burger, image: https://images.spoonacular.com/file/wximages/424571-312x231.png, imageType: png, restaurantChain: Burger King, servingSize: null, readableServingSize: null, servings: {number: 1, size: null, unit: null}},
 {id: 224185, title: Papa Burger, image: https://images.spoonacular.com/file/wximages/224185-312x231.jpg, imageType: jpg, restaurantChain: A&W, servingSize: 282g, readableServingSize: 7 oz, servings: {number: 1, size: 282, unit: g}}, 
 {id: 264615, title: Taco Burger w/ Cheese, image: https://images.spoonacular.com/file/wximages/264615-312x231.png, imageType: png, restaurantChain: Taco John's, servingSize: 142g, readableServingSize: 5 oz, servings: {number: 1, size: 142, unit: g}}], offset: 0, number: 4, totalMenuItems: 6748, processingTimeMs: 148, expires: 1672300739475, isStale: false}
*/

@HiveType(typeId: 1)
class Ingredient {
  @HiveField(0)
  String ingredient = '';
  @HiveField(1)
  String volume = '';
  Ingredient({required this.ingredient, required this.volume});

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      ingredient: json['ingredient'],
      volume: json['volume'],
    );
  }
}

@HiveType(typeId: 2)
class Cook {
  @HiveField(0)
  String step = '';
  @HiveField(1)
  String timeStep = '';
  Cook({required this.step, required this.timeStep});

  factory Cook.fromJson(Map<String, dynamic> json) {
    return Cook(
      step: json['step'],
      timeStep: json['timeStep'],
    );
  }
}
