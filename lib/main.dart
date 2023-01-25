import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_recipe/feauters/recipes/data/datasources/data_sourse_file.dart';
import 'package:flutter_recipe/feauters/recipes/data/datasources/data_sourse_hive.dart';
import 'package:flutter_recipe/feauters/recipes/data/repository/recipe_repository_impl.dart';
import 'package:flutter_recipe/feauters/recipes/presentation/bloc/list_recipe_cubit/list_recipe_cubit.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'feauters/recipes/data/datasources/data_source_strukt.dart';
import 'feauters/recipes/data/datasources/data_sours_remote.dart';

import 'package:path_provider/path_provider.dart' as path_provider;

import 'feauters/recipes/domain/entities/recipe.dart';
import 'feauters/recipes/presentation/screens/listRecipe.dart';
import 'feauters/recipes/presentation/screens/recipe_card.dart';
import 'feauters/recipes/presentation/screens/splash.dart';
import 'package:flutter_network_connectivity/flutter_network_connectivity.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // ignore: non_constant_identifier_names
//   var path = Directory.current.path;
//   //final AppDir= await path_provider.getApplicationDocumentsDirectory() as String;
// print('Path=$path');
  //Hive.init(path);
  await Hive.initFlutter();
  Hive.registerAdapter(RecipeAdapter());
  Hive.registerAdapter(IngredientAdapter());
  Hive.registerAdapter(CookAdapter());
  await Hive.openBox<Recipe>('Recipes');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

    @override
  Widget build(BuildContext context) {
    FlutterNetworkConnectivity flutterNetworkConnectivity =
        FlutterNetworkConnectivity(
      isContinousLookUp: true,
      lookUpDuration: const Duration(seconds: 5),
      lookUpUrl: 'example.com',
    );

    flutterNetworkConnectivity
        .getInternetAvailabilityStream()
        .listen((isInternetAvailable) {});
    // flutterNetworkConnectivity.registerAvailabilityListener();

    return MultiBlocProvider(
      providers: [
        BlocProvider<ListRecipeCubit>(
          create: (_) => ListRecipeCubit(
            recipeRepositoryImpl: RecipeRepositoryImpl(
                dataSourseLocalHive: DataSourseLocalHiveImpl(),
                dataSourseRemote: DataSourseRemoteImpl(),
                dataSourseFile: DataSourseFile(pathFile: 'assets/file/recipes_json.json'),
                ),
            // flutterNetworkConnectivity: flutterNetworkConnectivity

            //  RecipeRepositoryLocal(dataSourseLocalHive: DataSourseLocalHiveImpl() )
          )..getRecipe(),
        )
      ],
      child: MaterialApp(
        title: 'My recipe',
        theme: ThemeData(
          colorScheme:
              const ColorScheme.light(primary: Colors.white, onPrimary: Colors.black),
          //  primarySwatch: Colors.green ,
          primaryColor: Colors.white,
        ),

        // routeInformationParser: BeamerParser(),
        //  routerDelegate: routerDelegat,
        // backButtonDispatcher: BeamerBackButtonDispatcher(delegate: routerDelegat,),

        initialRoute: '/',
        routes: {
          '/': (context) => const Splash(),
          '/listRecipe': (context) => ListRecipe(),
          '/recipeCard': (context) => const RecipeCard()
        },

        //home:  const Splash()

        //const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
