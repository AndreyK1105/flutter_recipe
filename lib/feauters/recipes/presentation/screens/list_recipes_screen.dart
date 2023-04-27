import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_recipe/feauters/recipes/presentation/bloc/like_ikon/like_ikon_cubit.dart';
import 'package:flutter_recipe/feauters/recipes/presentation/bloc/list_recipe_cubit/list_recipe_cubit.dart';
import 'package:flutter_recipe/feauters/recipes/presentation/bloc/list_recipe_cubit/list_recipe_state.dart';

import '../../domain/entities/recipe.dart';
import '../bloc/header_widget_cubit/header_widget_cubit.dart';
import '../widgets/list_title_castom.dart';

class ListRecipesScreen extends StatelessWidget {
  const ListRecipesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    List<Recipe> recipes = [];
    late RecipeArguments recipeArguments;
    String userId =
        '63eb7b3ad9918a8acdaac1e1'; // гомер 63f1ef3454557a737ceb9b3 ; коля 63f1f0ac54557a737ceb9b3e ; света 63f1f14a54557a737ceb9b40 ; андрей 63eb7b3ad9918a8acdaac1e1

    return Scaffold(
      backgroundColor: const Color(0xFFECECEC),
      body: SafeArea(
        child: BlocBuilder<ListRecipeCubit, ListRecipeState>(
          builder: (context, state) {
            if (state is ListRecipeLoaded) {
              recipes = state.list;

              context.read<LikeIkonCubit>().loadLikes(recipes, userId);
              // print(
              //     'ListRecipesScreen  stste=== ${context.read<LikeIkonCubit>().state}');

              return ListView.builder(
                  // physics:const ScrollPhysics(parent:BouncingScrollPhysics() ) ,
                  physics: const BouncingScrollPhysics(),
                  itemCount: recipes.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 0),
                      child: GestureDetector(
                          child: ListTileCastom(
                              recipes: recipes,
                              recipeId: recipes[index].id,
                              userId: userId,
                              index: index,
                              title: recipes[index].name,
                              subtitle: recipes[index].time,
                              img: recipes[index].img),
                          onTap: () => {
                                context
                                    .read<HeaderWidgetCubit>()
                                    .getLikeUsersId(recipes[index].id, userId),
                                recipeArguments = RecipeArguments(
                                    recipes: recipes,
                                    recipe: recipes[index],
                                    userId: userId),
                                Navigator.pushNamed(context, '/recipeCard',
                                    arguments: recipeArguments),
                              }),
                    );
                  });
            }
            return const Center(
                child: CircularProgressIndicator(
              color: Color.fromARGB(255, 8, 148, 26),
            ));
          },
        ),
      ),
    );
  }
}

class RecipeArguments {
  List<Recipe> recipes;
  Recipe recipe;
  String userId;
  RecipeArguments(
      {required this.recipes, required this.recipe, required this.userId});
}
