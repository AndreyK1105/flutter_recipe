import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_recipe/feauters/recipes/data/datasources/data_sourse_hive.dart';
import 'package:flutter_recipe/feauters/recipes/data/repository/recipe_repository_impl.dart';
import 'package:flutter_recipe/feauters/recipes/presentation/bloc/comments_widget_bloc/comments_widget_cubit.dart';
import 'package:flutter_recipe/feauters/recipes/presentation/bloc/header_widget_cubit/header_widget_cubit.dart';
import 'package:flutter_recipe/feauters/recipes/presentation/bloc/list_recipe_cubit/list_recipe_cubit.dart';
import 'package:flutter_recipe/feauters/recipes/presentation/bloc/steps_widget_cubit/steps_widget_cubit.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'feauters/recipes/data/datasources/data_source_file.dart';
import 'feauters/recipes/data/datasources/data_source_remote.dart';

import 'package:path_provider/path_provider.dart' as path_provider;

import 'feauters/recipes/domain/entities/recipe.dart';
import 'package:flutter_network_connectivity/flutter_network_connectivity.dart';
import 'feauters/recipes/presentation/bloc/steps_widget_cubit/steps_widget_state.dart';
import 'feauters/recipes/presentation/screens/list_recipes_screen.dart';
import 'feauters/recipes/presentation/screens/recipe_details_screen.dart';
import 'feauters/recipes/presentation/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // var path = Directory.current.path;
  // final AppDir =
  //     await path_provider.getApplicationDocumentsDirectory() as String;
  // print('Path=$AppDir');
  // Hive.init(AppDir);

  await Hive.initFlutter();

  Hive.registerAdapter(RecipeAdapter());
  Hive.registerAdapter(IngredientAdapter());
  Hive.registerAdapter(CookAdapter());
  await Hive.openBox<Recipe>('Recipes1');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNetworkConnectivity flutterNetworkConnectivity =
        FlutterNetworkConnectivity(
      isContinousLookUp: true,
      lookUpDuration: const Duration(seconds: 2),
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
              dataSourseLocalHive: DataSourceLocalHiveImpl(),
              dataSourseRemote: DataSourceRemoteImpl(),
              dataSourseFile:
                  DataSourseFile(pathFile: 'assets/file/recipes_json.json'),
            ),
            // flutterNetworkConnectivity: flutterNetworkConnectivity

            //  RecipeRepositoryLocal(dataSourseLocalHive: DataSourseLocalHiveImpl() )
          )..getRecipe(),
        ),
        BlocProvider<HeaderWidgetCubit>(
            create: (_) => HeaderWidgetCubit(
                    recipeRepositoryImpl: RecipeRepositoryImpl(
                  dataSourseFile:
                      DataSourseFile(pathFile: 'assets/file/recipes_json.json'),
                  dataSourseLocalHive: DataSourceLocalHiveImpl(),
                  dataSourseRemote: DataSourceRemoteImpl(),
                ))),
        BlocProvider<CommentsWidgetCubit>(
            create: (_) => CommentsWidgetCubit(
                    recipeRepositoryImpl: RecipeRepositoryImpl(
                  dataSourseFile:
                      DataSourseFile(pathFile: 'assets/file/recipes_json.json'),
                  dataSourseLocalHive: DataSourceLocalHiveImpl(),
                  dataSourseRemote: DataSourceRemoteImpl(),
                ))),
        BlocProvider<StepsWidgetCobit>(
            create: (_) => StepsWidgetCobit(StepsWidgetStateEmpty()))
      ],
      child: MaterialApp(
        title: 'My recipe',
        theme: ThemeData(
          colorScheme: const ColorScheme.light(
              primary: Colors.white,
              onPrimary: Color.fromARGB(239, 15, 15, 15)),
          //  primarySwatch: Colors.green ,
          primaryColor: Colors.white,
        ),

        // routeInformationParser: BeamerParser(),
        //  routerDelegate: routerDelegat,
        // backButtonDispatcher: BeamerBackButtonDispatcher(delegate: routerDelegat,),

        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/listRecipe': (context) => ListRecipesScreen(),
          '/recipeCard': (context) => const RecipeDetailsScreen()
        },

        //home:  const Splash()

        //const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
