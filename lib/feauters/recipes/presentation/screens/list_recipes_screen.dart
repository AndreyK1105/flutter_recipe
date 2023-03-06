import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_recipe/feauters/recipes/presentation/bloc/comments_widget_bloc/comments_widget_cubit.dart';
import 'package:flutter_recipe/feauters/recipes/presentation/bloc/list_recipe_cubit/list_recipe_cubit.dart';
import 'package:flutter_recipe/feauters/recipes/presentation/bloc/list_recipe_cubit/list_recipe_state.dart';

import '../../domain/entities/recipe.dart';
import '../bloc/header_widget_cubit/header_widget_cubit.dart';
import '../widgets/list_title_castom.dart';

class ListRecipesScreen extends StatelessWidget {
  List<Recipe> recipes = [];
//final cubit=ListRecipeCubit(recipeRepository:  RecipeRepositoryRemote(dataSourseRemote: DataSourseRemoteImpl()));
  // var box = Hive.box<Recipe>('Recipes');
  List<Recipe> listRecipe = [];

  late Recipe recipe;
  late RecipeArguments recipeArguments;

  String userId =
      '63eb7b3ad9918a8acdaac1e1'; // гомер 63f1ef3454557a737ceb9b3 ; коля 63f1f0ac54557a737ceb9b3e ; света 63f1f14a54557a737ceb9b40 ; андрей 63eb7b3ad9918a8acdaac1e1

  ListRecipesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECECEC),
      //floatingActionButton: FloatingActionButton(onPressed: (){BlocProvider.of<ListRecipeCubit>(context).getRecipe();}),  //cubit.getRecipe();
      body: SafeArea(
        child: BlocBuilder<ListRecipeCubit, ListRecipeState>(
          builder: (context, state) {
            if (state is ListRecipeLoaded) {
              recipes = state.list;

              return ListView.builder(
                  // physics:const ScrollPhysics(parent:BouncingScrollPhysics() ) ,
                  physics: const BouncingScrollPhysics(),
                  itemCount: recipes.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 0),
                      child: GestureDetector(
                          child: ListTileCastom(
                              index: index,
                              title: recipes[index].name,
                              subtitle: recipes[index].time,
                              img: recipes[index].img),
                          onTap: () => {
                                context
                                    .read<HeaderWidgetCubit>()
                                    .getLikeUsersId(recipes[index].id, userId),
                                recipeArguments = RecipeArguments(
                                    recipe: recipes[index], userId: userId),
                                Navigator.pushNamed(context, '/recipeCard',
                                    arguments: recipeArguments),
                              }),
                    );
                  });
            }
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.black,
            ));
          },
        ),
      ),
      // /floatingActionButton: FloatingActionButton(onPressed: () async => {
      //   if(recipes.length>0){

      //     // box.addAll(recipes),
      //      //box.putAll ('listRecipe', recipes),

      //   },

      //     bz=box.length  ,
      //     print(bz),
      //     for(int i=0; i<bz; i++){
      //        recipe= await box.getAt(i)! as Recipe,
      //         listRecipe.add(recipe),
      //         print(listRecipe.last.cook[0].step)
      //     },
      // //    recipe=box.getAt(0)!,
      // // print(recipe.cook[1].step)
      // },),
    );
  }
}

class RecipeArguments {
  Recipe recipe;
  String userId;
  RecipeArguments({required this.recipe, required this.userId});
}
