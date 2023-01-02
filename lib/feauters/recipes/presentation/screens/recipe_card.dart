//import 'dart:js';

import 'package:flutter/material.dart';
//import 'package:flutter/src/widgets/container.dart';
//import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_recipe/feauters/recipes/domain/entities/recipe.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard({super.key});

  @override
  Widget build(BuildContext context) {
    Recipe recipe = ModalRoute.of(context)!.settings.arguments as Recipe;

    return Scaffold(
      appBar: AppBar(
        title: Text('Рецепт'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  recipe.name,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w500),
                )),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              const Icon(
                Icons.access_time,
                size: 20,
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                  child: Text(
                recipe.time,
                style: const TextStyle(color: Color(0xFF2ECC71)),
              ))
            ]),
            Container(
                height: 220,  width: 396,
                child: Image.asset(
                  recipe.img,
                  fit: BoxFit.fitWidth,
                )),
            //Image.network(recipe.img),
            const SizedBox(
              height: 15,
            ),
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
              height: 300,
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 3,
                      color: Color(0xFF2ECC71),
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: recipe.ingredients.length,
                  itemBuilder: (BuildContext context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Text(recipe.ingredients[index].ingredient,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ))),
                        Expanded(
                            child: Align(
                                alignment: Alignment.bottomRight,
                                child: Text(recipe.ingredients[index].volume,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ))))
                      ],
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
