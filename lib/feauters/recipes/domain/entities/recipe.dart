import 'package:flutter_recipe/feauters/recipes/domain/entities/user.dart';
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
  @HiveField(5)
  int aggregateLikes = 0;
  @HiveField(6)
  List<Comment> comments = [];
  @HiveField(7)
  String id = '';
  @HiveField(8)
  List<String> likeUsersId;
  Recipe({
    required this.name,
    required this.img,
    required this.time,
    required this.ingredients,
    required this.cook,
    required this.aggregateLikes,
    required this.comments,
    required this.id,
    required this.likeUsersId,
  });
  /*
  factory Recipe.fromRecipeSpoon(RecipeSpoon recipeSpoon) {
    List<Ingredient> ingredients = [];
    for (var ingredientSpoon in (recipeSpoon.ingredients)) {
      ingredients.add(
        Ingredient.fromIngredientSpoon(ingredientSpoon),
      );
    }

    List<Cook> cooks = [];
    for (var stepSpoon in (recipeSpoon.steps)) {
      cooks.add(
        Cook.fromSteps(stepSpoon),
      );
    }
    // print(cooks[0]);
    return Recipe(
      name: recipeSpoon.title,
      img: recipeSpoon.image,
      time: '',
      ingredients: ingredients,
      cook: cooks,
      aggregateLikes: 0,
      comments: [],
    );
  }
  */
  factory Recipe.fromJson(Map<String, dynamic> json) {
    // print('json[image]=${json['image']}');
    return Recipe(
      name: (json['name'] != null) ? (json['name'] as String) : '',
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
          : [],
      aggregateLikes:
          (json['aggregateLikes'] != null) ? json['aggregateLikes'] as int : 0,
      comments: (json['comments'] != null)
          ? ((json['comments'] as List)
              .map((e) => Comment.fromJson(e))
              .toList())
          : [],
      id: (json['_id'] != null) ? (json['_id'] as String) : "",
      likeUsersId: (json['likeUsersId'] != null)
          ? (json['likeUsersId'] as List)
              .map((e) => e['userId'] as String)
              .toList()
          : [],
    );
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
/*
  factory Ingredient.fromIngredientSpoon(IngredientSpoon ingredientSpoon) {
    return Ingredient(
      ingredient: ingredientSpoon.name,
      volume: ingredientSpoon.amount.toString() + ' ' + ingredientSpoon.unit,
    );
  }
*/
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
  @HiveField(2)
  int timeStepSec = 0;
  Cook({required this.step, required this.timeStep, required this.timeStepSec});
/*
  factory Cook.fromSteps(Steps steps) {
    return Cook(
      step: steps.step,
      timeStep: ' ',
    );
  }
*/
  factory Cook.fromJson(Map<String, dynamic> json) {
    return Cook(
      step: json['step'] != null ? json['step'] as String : '',
      timeStep: json['timeStep'] != null ? json['timeStep'] as String : '',
      timeStepSec: json['timeStepSec'] != null ? json['timeStepSec'] as int : 0,
    );
  }
}

@HiveType(typeId: 3)
class Comment {
  @HiveField(0)
  String user;
  @HiveField(1)
  String comment;
  @HiveField(2)
  String img;
  Comment({required this.user, required this.comment, required this.img});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      user: (json['user'] != null) ? json['user'] as String : '',
      comment: (json['comment'] != null) ? json['comment'] as String : '',
      img: (json['img'] != null) ? json['img'] as String : '',
    );
  }
  static Map<String, dynamic> toJson(Comment comment) {
    return {
      'user': comment.user,
      'comment': comment.comment,
      'img': comment.img,
    };
  }
}
//flutter packages pub run build_runner build