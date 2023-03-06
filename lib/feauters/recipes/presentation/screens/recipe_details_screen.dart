//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter/src/widgets/container.dart';
//import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_recipe/feauters/recipes/domain/entities/recipe.dart';
import 'package:flutter_recipe/feauters/recipes/presentation/bloc/steps_widget_cubit/steps_widget_cubit.dart';
import 'package:flutter_recipe/feauters/recipes/presentation/bloc/steps_widget_cubit/steps_widget_state.dart';
import 'package:flutter_recipe/feauters/recipes/presentation/screens/list_recipes_screen.dart';
import 'package:flutter_recipe/feauters/recipes/presentation/widgets/bookmark_icon.dart';
import 'package:flutter_recipe/feauters/recipes/presentation/widgets/header_widget.dart';
import 'package:flutter_recipe/feauters/recipes/presentation/widgets/step_cook_widget.dart';
import 'package:intl/intl.dart';

import '../widgets/comments.dart';

class RecipeDetailsScreen extends StatelessWidget {
  const RecipeDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RecipeArguments recipeArguments =
        ModalRoute.of(context)!.settings.arguments as RecipeArguments;
    Recipe recipe = recipeArguments.recipe;
    String userId = recipeArguments.userId;
    // int timeCookingSec = 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Рецепт'),
        // bottom: botomAppBar(context),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ///   BookmarkIcon(),
            //Text(times),
            HeaderWidget(recipe: recipe, userId: userId),
            // header(recipe),
            const SizedBox(height: 15),
            ingredients(recipe),
            const SizedBox(
              height: 20,
            ),
            StepCookWidget(recipe: recipe),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              thickness: 1,
              color: Color(0xFF797676),
            ),
            const SizedBox(
              height: 20,
            ),
            CommentsWidget(
              comments: recipe.comments,
              userId: userId,
              recipeId: recipe.id,
            ),
          ],
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
          Expanded(
            child: Text(recipe.name,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
          ),
          IconButton(
              icon: const Icon(Icons.favorite),
              color: Colors.red,
              onPressed: () {})
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
      SizedBox(
        height: 220,
        width: 396,
        child: Stack(
          children: [
            SizedBox(
                height: 220,
                width: 396,
                child: Image.asset(
                  recipe.img,
                  fit: BoxFit.fitWidth,
                )),
            const Align(
                alignment: Alignment.bottomRight,
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

ingredients(Recipe recipe) {
  return Column(
    children: [
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
                color: const Color(0xFF2ECC71),
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
            )),
      ),
    ],
  );
}

PreferredSize botomAppBar(BuildContext context) {
  // var state = context.watch<StepsWidgetCobit>().state;
  // if (state is StepsWidgetStateCooking) {
  //   int timeCookingSec = state.timeStepList.reduce((a, b) => a + b);
  //   print('timeCookingSec=$timeCookingSec');
  // }
  return PreferredSize(
    preferredSize: const Size.fromHeight(30),
    child: Padding(
      padding: const EdgeInsets.only(left: 100, right: 100),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'timer',
              style: TextStyle(fontSize: 15),
            ),
            Text(
              '00:00',
              style: TextStyle(fontSize: 24),
            ),
          ]),
    ),
  );
}

Widget ingredientRow({required String ingridient, required String valume}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        '· $ingridient',
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      Text(valume)
    ],
  );
}
