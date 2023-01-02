import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_recipe/feauters/recipes/data/datasources/data_sours_remote.dart';
import 'package:flutter_recipe/feauters/recipes/data/repository/repository_remote.dart';
import 'package:flutter_recipe/feauters/recipes/presentation/bloc/list_recipe_cubit/list_recipe_cubit.dart';
import 'package:flutter_recipe/feauters/recipes/presentation/screens/listRecipe.dart';

import 'feauters/recipes/data/datasources/data_source_strukt.dart';
import 'feauters/recipes/data/repository/repository_local.dart';
import 'feauters/recipes/presentation/screens/recipe_card.dart';
import 'feauters/recipes/presentation/screens/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider (
      providers: [
        BlocProvider<ListRecipeCubit>(
          create: (_)=> ListRecipeCubit(recipeRepository: 
          
          //RecipeRepositoryRemote(dataSourseRemote: DataSourseRemoteImpl())

          RecipeRepositoryLocal(dataSourseStrukt: DataSourseStrukt() )

          
          )..getRecipe(), )
      ],
      child: MaterialApp(
        title: 'My recipe',
        theme: ThemeData(
      
        colorScheme: ColorScheme.light(primary: Colors.white, onPrimary: Colors.black),
        //  primarySwatch: Colors.green ,
        primaryColor: Colors.white,
        ),
       initialRoute: '/',
       routes: {
        '/':(context) => const Splash(),
        '/listRecipe':(context) => ListRecipe(),
        '/recipeCard':(context) => RecipeCard()
       },
        
       // home:  const Splash()
        
        //const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

