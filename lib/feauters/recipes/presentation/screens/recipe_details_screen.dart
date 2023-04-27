import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_recipe/feauters/recipes/domain/entities/recipe.dart';
import 'package:flutter_recipe/feauters/recipes/presentation/bloc/steps_widget_cubit/steps_widget_cubit.dart';
import 'package:flutter_recipe/feauters/recipes/presentation/bloc/steps_widget_cubit/steps_widget_state.dart';
import 'package:flutter_recipe/feauters/recipes/presentation/screens/list_recipes_screen.dart';
import 'package:flutter_recipe/feauters/recipes/presentation/widgets/header_widget.dart';
import 'package:flutter_recipe/feauters/recipes/presentation/widgets/step_cook_widget.dart';

import '../widgets/bottom_app_bar_widget.dart';
import '../widgets/comments.dart';
import '../widgets/gallery_widget.dart';

class RecipeDetailsScreen extends StatelessWidget {
  const RecipeDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RecipeArguments recipeArguments =
        ModalRoute.of(context)!.settings.arguments as RecipeArguments;
    Recipe recipe = recipeArguments.recipe;
    String userId = recipeArguments.userId;
    List<Recipe> recipes = recipeArguments.recipes;

    return BlocConsumer<StepsWidgetCobit, StepsWidgetState>(
        listener: (context, sate) {},
        buildWhen: (previous, current) =>
            !(previous is StepsWidgetStateCooking &&
                current is StepsWidgetStateCooking),
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: state is StepsWidgetStateCooking
                  ? const Color.fromRGBO(46, 204, 113, 1)
                  : null,
              title: const Text('Рецепт'),
              bottom: const PreferredSize(
                  preferredSize: Size.fromHeight(30),
                  child: BottomAppBarWidget()),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    HeaderWidget(
                        recipes: recipes, recipe: recipe, userId: userId),
                    const SizedBox(height: 15),
                    GalleryWidget(
                      recipeId: recipe.id,
                    ),
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
            ),
          );
        });
  }
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
