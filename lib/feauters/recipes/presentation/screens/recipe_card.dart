//import 'dart:js';

import 'package:flutter/material.dart';
//import 'package:flutter/src/widgets/container.dart';
//import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_recipe/feauters/recipes/domain/entities/recipe.dart';
import 'package:flutter_recipe/feauters/recipes/presentation/widgets/bookmark_icon.dart';
import 'package:flutter_recipe/feauters/recipes/presentation/widgets/coments.dart';
import 'package:flutter_recipe/feauters/recipes/presentation/widgets/header_widget.dart';
import 'package:flutter_recipe/feauters/recipes/presentation/widgets/step_cook_widget.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard({super.key});

  @override
  Widget build(BuildContext context) {
    Recipe recipe = ModalRoute.of(context)!.settings.arguments as Recipe;

    return Scaffold(
      appBar: AppBar(
        title: Text('Рецепт'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [

             ///   BookmarkIcon(),
                HeaderWidget(recipe: recipe),
               // header(recipe),  
                const SizedBox(height: 15 ),
                ingredients(recipe),
                const SizedBox( height: 20, ),
                stepsCook(recipe),
                 const SizedBox( height: 20, ),
                 Divider(thickness: 1,color: Color(0xFF797676),),
                 const SizedBox( height: 20, ),
                CommentsWidget(), 

               
            ],
          ),
        ),
      ),
    );
  }

 
}

header(Recipe recipe) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded (
            child: Text(recipe.name,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
          ),
                  IconButton(icon: Icon(Icons.favorite), color: Colors.red, onPressed: () { } )
        ],
      ),
      const SizedBox(height: 15),
      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        const Icon(
          Icons.access_time,
          size: 20,
        ),
        const SizedBox(width: 15),
        Expanded(
            child: Text(
          recipe.time,
          style: const TextStyle(color: Color(0xFF2ECC71)),
        ))
      ]),
      const SizedBox(height: 15),
      SizedBox( height: 220,
                width: 396,
        child: Stack(
          children: [
            Container(
                height: 220,
                width: 396,
                child: Image.asset(
                  recipe.img,
                  fit: BoxFit.fitWidth,
                )),
                 const Align(
                      alignment: Alignment.bottomRight ,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 13),
                        child: BookmarkIcon(),
                      )),
          ],
        ),
      ),
            //Image.network(recipe.img),
             
    ],
  );
}

ingredients(Recipe recipe){return

  Column(children: [
           const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text('Ингредиенты',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF165932)))),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: 396,
                // height: 200,
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 3,
                        color: Color(0xFF2ECC71),
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: List<Widget>.generate(
                          recipe.ingredients.length,
                          (index) => ingredientRow(
                              ingridient: recipe.ingredients[index].ingredient,
                              valume: recipe.ingredients[index].volume)),
                    )
                    ),
              ), 
  ],);
}

stepsCook(Recipe recipe){ return Column(children: [
          
           const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text('Шаги приготовления',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF165932)))),
              const SizedBox(height: 20,),

              Column(
                children: List<Widget>.generate(
                    recipe.cook.length,
                    (index) => StepCookWidget(
                        cook: recipe.cook[index], stepNumb: index + 1)),
              ),
              const SizedBox(height: 20,),

              InkWell (
                splashColor: Colors.amber,
                onTap: () => {},
                child: Container(width: 232, height: 48,
                decoration: BoxDecoration(color: Color(0xFF165932), borderRadius: BorderRadius.circular(24)),
                child:Center(child: Text('Начать готовить', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight:FontWeight.w500,))) ,
                ),
              ),
],);}

// coments(){return Column(children: [

//   Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
//     Expanded(flex: 1, child: CircleAvatar (radius: 31,  backgroundImage: AssetImage( 'assets/images/back_food.png'))),
//     Expanded(flex: 3,
//       child: Column(children: [
//         Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('name'), Text('data')] ),
//                const SizedBox(height: 20,),
//                Text ('DescriptionЯ не большой любитель рыбы, но решила приготовить по этому рецепту и просто влюбилась!  '),
//                const SizedBox(height: 20,),
//                SizedBox(
//                 width: 315, height: 160,
//                  child: FittedBox ( fit: BoxFit.values.first ,

//                    child: Image.asset('assets/images/recipe_steik.png',
//                    // fit: BoxFit.contain,
//                     ),
//                  ),
//                ) ,
               
//       ],),
//     ) , 
  

//   ],),
//   const SizedBox(height: 20,),

//    Container(
//                 //width: 400,
//                  height:72 ,
//                 decoration: BoxDecoration(
//                     border: Border.all(
//                         width: 2,
//                         color: Color(0xFF165932),
//                         style: BorderStyle.solid),
//                     borderRadius: BorderRadius.circular(5)),
//                  child: Row(
//                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                 Expanded(child: Padding(
//                   padding: const EdgeInsets.only(left: 14),
//                   child: TextField( ),
//                 )),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 14, right: 14),
//                   child: InkWell(
//                           splashColor: Colors.amber,
//                     onTap: () => {},
//                     child: Image.asset('assets/icons_png/icons8-изображение-96 1.png')),
//                 ),
//                  ]),)  

// ],);


//}



Widget ingredientRow({required String ingridient, required String valume}) {
  return Row(
    children: [Text(ingridient), Text(valume)],
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
  );
}
