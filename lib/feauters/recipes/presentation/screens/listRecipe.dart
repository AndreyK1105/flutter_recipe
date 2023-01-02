
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_recipe/feauters/recipes/presentation/bloc/list_recipe_cubit/list_recipe_cubit.dart';
import 'package:flutter_recipe/feauters/recipes/presentation/bloc/list_recipe_cubit/list_recipe_state.dart';

import '../../data/datasources/data_sours_remote.dart';
import '../../data/repository/repository_remote.dart';
import '../../domain/entities/recipe.dart';
import '../widgets/list_title_castom.dart';

class ListRecipe extends StatelessWidget {
 
List<Recipe> recipes=[];
final cubit=ListRecipeCubit(recipeRepository:  RecipeRepositoryRemote(dataSourseRemote: DataSourseRemoteImpl()));
  @override
  Widget build(BuildContext context) {
     

    return Scaffold(
      backgroundColor: const Color(0xFFECECEC),
      floatingActionButton: FloatingActionButton(onPressed: (){BlocProvider.of<ListRecipeCubit>(context).getRecipe();}),  //cubit.getRecipe();
      body: BlocBuilder<ListRecipeCubit, ListRecipeState>(
        builder: (context, state) {

          if(state is ListRecipeLoaded){

          recipes =state.list;

          return ListView.builder(
           // physics:const ScrollPhysics(parent:BouncingScrollPhysics() ) ,
            physics:const BouncingScrollPhysics() ,
            itemCount: recipes.length,
            //prototypeItem: ListTile(title: Text(recipes.first.name)),
            itemBuilder: (context, index) {
             return 

             Padding(
               padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 0),
               child: GestureDetector(
                child: ListTileCastom(index: index, title: recipes[index].name, subtitle: recipes[index].time, img: recipes[index].img),
                onTap: () => Navigator.pushNamed(context, '/recipeCard', arguments: recipes[index]),
                ),
                
             );
           
             });
        }
        return const CircularProgressIndicator();
        },
      ),
  
    );
  }
}
// ignore: must_be_immutabl