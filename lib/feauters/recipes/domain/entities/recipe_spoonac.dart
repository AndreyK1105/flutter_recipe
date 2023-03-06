/*

import 'package:hive/hive.dart';
//part 'recipe_spoonac.g.dart';

@HiveType(typeId: 0)
class RecipeSpoon {
  @HiveField(0)
  int id;
  @HiveField(1)
  String title = '';
  @HiveField(2)
  String image = '';
  @HiveField(3)
  int readyInMinutes;
  @HiveField(4)
  int aggregateLikes = 0;
  @HiveField(5)
  List<IngredientSpoon> ingredients = [];
  @HiveField(6)
  List<Steps> steps = [];

  RecipeSpoon(
      {required this.id,
      required this.title,
      required this.image,
      required this.readyInMinutes,
      required this.aggregateLikes,
      required this.ingredients,
      required this.steps});

  factory RecipeSpoon.fromJson(Map<String, dynamic> json, List<Steps> steps) {
    //print('json[image]=${json['image']}');
    return RecipeSpoon(
      id: (json['id'] != null) ? (json['id'] as int) : 0,
      title: (json['title'] != null) ? (json['title'] as String) : ' ',
      // if(json['image']==null) {img: ''} else {img: json['image']as String, } ;
      image: (json['image'] != null) ? (json['image'] as String) : "",
      aggregateLikes: (json['aggregateLikes'] != null)
          ? (json['aggregateLikes'] as int)
          : 0,
      readyInMinutes: (json['readyInMinutes'] != null)
          ? (json['readyInMinutes'] as int)
          : 0,
      ingredients: (json['extendedIngredients'] != null)
          ? ((json['extendedIngredients'] as List)
              .map((e) => IngredientSpoon.fromJson(e))
              .toList())
          : [],
      steps: steps,
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
class IngredientSpoon {
  @HiveField(0)
  String name = '';
  @HiveField(1)
  double amount;
  @HiveField(2)
  String unit = '';
  IngredientSpoon(
      {required this.name, required this.amount, required this.unit});

  factory IngredientSpoon.fromJson(Map<String, dynamic> json) {
    return IngredientSpoon(
      name: (json['name'] != null) ? json['name'] : '',
      amount: (json['amount'] != null) ? json['amount'] : 0.0,
      unit: (json['unit'] != null) ? json['unit'] : '',
    );
  }
}

@HiveType(typeId: 2)
class Steps {
  @HiveField(0)
  String step = '';
  @HiveField(1)
  int number;
  Steps({required this.step, required this.number});

  factory Steps.fromJson(Map<String, dynamic> json) {
    return Steps(
      step: (json['step'] != null) ? json['step'] : '',
      number: 1, //json['steps']['number'] as int,
    );
  }
}
*/



/*
{
            "aisle": "Oil, Vinegar, Salad Dressing",
            "amount": 1.0,
            "consitency": "liquid",
            "id": 1034053,
            "image": "olive-oil.jpg",
            "measures": {
                "metric": {
                    "amount": 1.0,
                    "unitLong": "Tbsp",
                    "unitShort": "Tbsp"
                },
                "us": {
                    "amount": 1.0,
                    "unitLong": "Tbsp",
                    "unitShort": "Tbsp"
                }
            },
            "meta": [],
            "name": "extra virgin olive oil",
            "original": "1-2 tbsp extra virgin olive oil",
            "originalName": "extra virgin olive oil",
            "unit": "tbsp"
        },

        [
    {
        "name": "",
        "steps": [
            {
                "equipment": [
                    {
                        "id": 404784,
                        "image": "oven.jpg",
                        "name": "oven",
                        "temperature": {
                            "number": 200.0,
                            "unit": "Fahrenheit"
                        }
                    }
                ],
                "ingredients": [],
                "number": 1,
                "step": "Preheat the oven to 200 degrees F."
            },
            {
                "equipment": [
                    {
                        "id": 404661,
                        "image": "whisk.png",
                        "name": "whisk"
                    },
                    {
                        "id": 404783,
                        "image": "bowl.jpg",
                        "name": "bowl"
                    }
                ],
                "ingredients": [
                    {
                        "id": 19334,
                        "image": "light-brown-sugar.jpg",
                        "name": "light brown sugar"
                    },
                    {
                        "id": 19335,
                        "image": "sugar-in-bowl.png",
                        "name": "granulated sugar"
                    },
                    {
                        "id": 18371,
                        "image": "white-powder.jpg",
                        "name": "baking powder"
                    },
                    {
                        "id": 18372,
                        "image": "white-powder.jpg",
                        "name": "baking soda"
                    },
                    {
                        "id": 12142,
                        "image": "pecans.jpg",
                        "name": "pecans"
                    },
                    {
                        "id": 20081,
                        "image": "flour.png",
                        "name": "all purpose flour"
                    },
                    {
                        "id": 2047,
                        "image": "salt.jpg",
                        "name": "salt"
                    }
                ],
                "number": 2,
                "step": "Whisk together the flour, pecans, granulated sugar, light brown sugar, baking powder, baking soda, and salt in a medium bowl."
            },
            {
                "equipment": [
                    {
                        "id": 404661,
                        "image": "whisk.png",
                        "name": "whisk"
                    },
                    {
                        "id": 404783,
                        "image": "bowl.jpg",
                        "name": "bowl"
                    }
                ],
                "ingredients": [
                    {
                        "id": 2050,
                        "image": "vanilla-extract.jpg",
                        "name": "vanilla extract"
                    },
                    {
                        "id": 93622,
                        "image": "vanilla.jpg",
                        "name": "vanilla bean"
                    },
                    {
                        "id": 1230,
                        "image": "buttermilk.jpg",
                        "name": "buttermilk"
                    },
                    {
                        "id": 1123,
                        "image": "egg.png",
                        "name": "egg"
                    }
                ],
                "number": 3,
                "step": "Whisk together the eggs, buttermilk, butter and vanilla extract and vanilla bean in a small bowl."
            },
            {
                "equipment": [],
                "ingredients": [
                    {
                        "id": 1123,
                        "image": "egg.png",
                        "name": "egg"
                    }
                ],
                "number": 4,
                "step": "Add the egg mixture to the dry mixture and gently mix to combine. Do not overmix."
            },
            {
                "equipment": [],
                "ingredients": [],
                "length": {
                    "number": 15,
                    "unit": "minutes"
                },
                "number": 5,
                "step": "Let the batter sit at room temperature for at least 15 minutes and up to 30 minutes before using."
            },
            {
                "equipment": [
                    {
                        "id": 404779,
                        "image": "griddle.jpg",
                        "name": "griddle"
                    },
                    {
                        "id": 404645,
                        "image": "pan.png",
                        "name": "frying pan"
                    }
                ],
                "ingredients": [],
                "length": {
                    "number": 3,
                    "unit": "minutes"
                },
                "number": 6,
                "step": "Heat a cast iron or nonstick griddle pan over medium heat and brush with melted butter. Once the butter begins to sizzle, use 2 tablespoons of the batter for each pancake and cook until the bubbles appear on the surface and the bottom is golden brown, about 2 minutes, flip over and cook until the bottom is golden brown, 1 to 2 minutes longer."
            },
            {
                "equipment": [
                    {
                        "id": 404784,
                        "image": "oven.jpg",
                        "name": "oven",
                        "temperature": {
                            "number": 200.0,
                            "unit": "Fahrenheit"
                        }
                    }
                ],
                "ingredients": [],
                "number": 7,
                "step": "Transfer the pancakes to a platter and keep warm in a 200 degree F oven."
            },
            {
                "equipment": [],
                "ingredients": [
                    {
                        "id": 10014037,
                        "image": "bourbon.png",
                        "name": "bourbon"
                    }
                ],
                "number": 8,
                "step": "Serve 6 pancakes per person, top each with some of the bourbon butter."
            },
            {
                "equipment": [],
                "ingredients": [
                    {
                        "id": 19336,
                        "image": "powdered-sugar.jpg",
                        "name": "powdered sugar"
                    },
                    {
                        "id": 19911,
                        "image": "maple-syrup.png",
                        "name": "maple syrup"
                    }
                ],
                "number": 9,
                "step": "Drizzle with warm maple syrup and dust with confectioners' sugar."
            },
            {
                "equipment": [],
                "ingredients": [
                    {
                        "id": 12142,
                        "image": "pecans.jpg",
                        "name": "pecans"
                    }
                ],
                "number": 10,
                "step": "Garnish with fresh mint sprigs and more toasted pecans, if desired."
            }
        ]
    },
    {
        "name": "Bourbon Molasses Butter",
        "steps": [
            {
                "equipment": [
                    {
                        "id": 404669,
                        "image": "sauce-pan.jpg",
                        "name": "sauce pan"
                    }
                ],
                "ingredients": [
                    {
                        "id": 10014037,
                        "image": "bourbon.png",
                        "name": "bourbon"
                    },
                    {
                        "id": 19335,
                        "image": "sugar-in-bowl.png",
                        "name": "sugar"
                    }
                ],
                "number": 1,
                "step": "Combine the bourbon and sugar in a small saucepan and cook over high heat until reduced to 3 tablespoons, remove and let cool."
            },
            {
                "equipment": [
                    {
                        "id": 404771,
                        "image": "food-processor.png",
                        "name": "food processor"
                    }
                ],
                "ingredients": [
                    {
                        "id": 19304,
                        "image": "molasses.jpg",
                        "name": "molasses"
                    },
                    {
                        "id": 10014037,
                        "image": "bourbon.png",
                        "name": "bourbon"
                    },
                    {
                        "id": 2047,
                        "image": "salt.jpg",
                        "name": "salt"
                    }
                ],
                "number": 2,
                "step": "Put the butter, molasses, salt and cooled bourbon mixture in a food processor and process until smooth."
            },
            {
                "equipment": [
                    {
                        "id": 404730,
                        "image": "plastic-wrap.jpg",
                        "name": "plastic wrap"
                    },
                    {
                        "id": 404783,
                        "image": "bowl.jpg",
                        "name": "bowl"
                    }
                ],
                "ingredients": [],
                "number": 3,
                "step": "Scrape into a bowl, cover with plastic wrap and refrigerate for at least 1 hour to allow the flavors to meld."
            },
            {
                "equipment": [],
                "ingredients": [],
                "length": {
                    "number": 30,
                    "unit": "minutes"
                },
                "number": 4,
                "step": "Remove from the refrigerator about 30 minutes before using to soften."
            }
        ]
    }
]*/