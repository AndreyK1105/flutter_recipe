import 'package:flutter/material.dart';
import 'package:flutter_recipe/screens/listRecipe.dart';

import 'package:flutter_recipe/screens/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'My recipe',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: const Splash());
  }
}
