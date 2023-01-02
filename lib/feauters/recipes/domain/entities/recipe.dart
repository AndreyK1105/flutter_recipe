class Recipe {
  String name='';
  String img='';
  String time='';
  List <Ingredient> ingredients=[];
  List<Cook> cook=[];
  Recipe({required this.name, required this.img, required this.time, 
  required this.ingredients, required this.cook});

  factory Recipe.fromJson(Map<String, dynamic> json){
    print('json[title]=${json['image']}');
    return Recipe(name: json['title'] as String,
     img: json['image'] as String, 
     time: 'time', 
    ingredients: [], cook: []);
  }
}

/*
{type: menuItem, menuItems: [{id: 419357, title: Burger Sliders, image: https://images.spoonacular.com/file/wximages/419357-312x231.png, imageType: png, restaurantChain: Hooters, servingSize: null, readableServingSize: null, servings: {number: 1, size: null, unit: null}}, 
{id: 424571, title: Bacon King Burger, image: https://images.spoonacular.com/file/wximages/424571-312x231.png, imageType: png, restaurantChain: Burger King, servingSize: null, readableServingSize: null, servings: {number: 1, size: null, unit: null}},
 {id: 224185, title: Papa Burger, image: https://images.spoonacular.com/file/wximages/224185-312x231.jpg, imageType: jpg, restaurantChain: A&W, servingSize: 282g, readableServingSize: 7 oz, servings: {number: 1, size: 282, unit: g}}, 
 {id: 264615, title: Taco Burger w/ Cheese, image: https://images.spoonacular.com/file/wximages/264615-312x231.png, imageType: png, restaurantChain: Taco John's, servingSize: 142g, readableServingSize: 5 oz, servings: {number: 1, size: 142, unit: g}}], offset: 0, number: 4, totalMenuItems: 6748, processingTimeMs: 148, expires: 1672300739475, isStale: false}
*/

class Ingredient {

  String ingredient ='';
  String volume ='';
Ingredient({required this.ingredient, required this.volume});
}
 
class Cook {
  String step='';
  String timeStep='';
  Cook({required this.step, required this.timeStep});
}