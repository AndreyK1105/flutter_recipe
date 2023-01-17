import '../../domain/entities/recipe.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

abstract class DataSourseRemote {
 Future< List<Recipe>> getRecipeRemote();
}

class DataSourseRemoteImpl implements DataSourseRemote {

final dio=Dio();

  @override
  Future<List<Recipe>> getRecipeRemote() async {
 var response = await dio.get('https://api.spoonacular.com/food/menuItems/search?apiKey=f64ea6b1ea14465c801f25972db69cd1&query=burger&number=20'); 
    // print('response.statusCode=${response.statusCode}');
    //  print('response.data=${response.data}');
    //throw UnimplementedError();
    if(response.statusCode==200){
     final recipes =response.data;
    // print('response.statusCode=${response.statusCode}');
    // print('response.data=${response.data}');
     List<Recipe> list=[];
     list= await(recipes['menuItems'] as List).map((recipe) => Recipe.fromJson(recipe)).toList();
     print(list[0]);
     print('lengh list<Recipe>=${list.length}');
     return list;
    
  }else {
    print('response.statusCode=${response.statusCode}');
    return throw UnimplementedError();};


}
}

/*
{type: menuItem, menuItems: [{id: 419357, title: Burger Sliders, image: https://images.spoonacular.com/file/wximages/419357-312x231.png, imageType: png, restaurantChain: Hooters, servingSize: null, readableServingSize: null, servings: {number: 1, size: null, unit: null}}, 
{id: 424571, title: Bacon King Burger, image: https://images.spoonacular.com/file/wximages/424571-312x231.png, imageType: png, restaurantChain: Burger King, servingSize: null, readableServingSize: null, servings: {number: 1, size: null, unit: null}},
 {id: 224185, title: Papa Burger, image: https://images.spoonacular.com/file/wximages/224185-312x231.jpg, imageType: jpg, restaurantChain: A&W, servingSize: 282g, readableServingSize: 7 oz, servings: {number: 1, size: 282, unit: g}}, 
 {id: 264615, title: Taco Burger w/ Cheese, image: https://images.spoonacular.com/file/wximages/264615-312x231.png, imageType: png, restaurantChain: Taco John's, servingSize: 142g, readableServingSize: 5 oz, servings: {number: 1, size: 142, unit: g}}], offset: 0, number: 4, totalMenuItems: 6748, processingTimeMs: 148, expires: 1672300739475, isStale: false}
*/