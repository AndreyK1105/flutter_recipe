import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_recipe/feauters/recipes/data/datasources/data_sourse_hive.dart';
import 'package:flutter_recipe/feauters/recipes/presentation/bloc/list_recipe_cubit/list_recipe_cubit.dart';
import 'package:hive/hive.dart';
import 'feauters/recipes/data/datasources/data_source_strukt.dart';
import 'feauters/recipes/data/repository/repository_local.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'feauters/recipes/domain/entities/recipe.dart';
import 'feauters/recipes/presentation/screens/listRecipe.dart';
import 'feauters/recipes/presentation/screens/recipe_card.dart';
import 'feauters/recipes/presentation/screens/splash.dart';

void main() async {

  // ignore: non_constant_identifier_names
  final AppDir= await path_provider.getApplicationDocumentsDirectory();
  Hive.init(AppDir.path);
  Hive.registerAdapter(RecipeAdapter());
  Hive.registerAdapter(IngredientAdapter());
  Hive.registerAdapter(CookAdapter()); 
  await Hive.openBox<Recipe>('Recipes');
 
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   const MyApp({super.key});

  // final routerDelegat = BeamerDelegate(
  //   initialPath: '/',
  //   locationBuilder: RoutesLocationBuilder( 
  //     routes:{
  //       '*':(context, state, data)=> const ScaffoldWithBottomNavBar()
  //     },
  //      ),
  //      );

 
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider (
      providers: [
        BlocProvider<ListRecipeCubit>(
          create: (_)=> ListRecipeCubit(recipeRepository: 
          
          //RecipeRepositoryRemote(dataSourseRemote: DataSourseRemoteImpl())

          RecipeRepositoryLocal(dataSourseLocalHive: DataSourseLocalHiveImpl() )



          
          )..getRecipe(), )
      ],
      child: MaterialApp(
        title: 'My recipe',
        theme: ThemeData(
      
        colorScheme: ColorScheme.light(primary: Colors.white, onPrimary: Colors.black),
        //  primarySwatch: Colors.green ,
        primaryColor: Colors.white,
        ),
       
       // routeInformationParser: BeamerParser(),
        //  routerDelegate: routerDelegat,
        // backButtonDispatcher: BeamerBackButtonDispatcher(delegate: routerDelegat,),


       initialRoute: '/',
       routes: {
        '/':(context) => const Splash(),
        '/listRecipe':(context) => ListRecipe(),
        '/recipeCard':(context) => RecipeCard()
       },
        
       //home:  const Splash()
        
        //const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

