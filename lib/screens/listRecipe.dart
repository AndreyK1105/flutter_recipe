import 'package:flutter/material.dart';
import 'package:flutter_recipe/data/data_source_strukture.dart';
import 'package:flutter_recipe/recipe.dart';

class ListRecipe extends StatefulWidget {
  const ListRecipe({super.key});

  @override
  State<ListRecipe> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ListRecipe> {
 
  List<Recipe> recipes = [];
DataSourseStrukture dataSourseStrukt=DataSourseStrukture();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return  FutureBuilder <List<Recipe>>(
      future: dataSourseStrukt.getRecipe(),
      initialData: recipes,
      builder: (context, AsyncSnapshot recipesSnapsshot) {
        if (recipesSnapsshot.hasData){

           return SafeArea (
          child: Scaffold(
            backgroundColor: const Color(0xFFECECEC),
            body: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: recipesSnapsshot.data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 24),
                    child: ListTileCastom(
                        index: index,
                        title: recipesSnapsshot.data[index].name,
                        subtitle: recipesSnapsshot.data[index].time,
                        img: recipesSnapsshot.data[index].img),
                  );
                }),
          ),
        );
        }
       return const CircularProgressIndicator();
      }
    );
  }
}


class ListTileCastom extends StatelessWidget {
final  int index ;
  final String title ;
  final String subtitle ;
  final String img ;
   const ListTileCastom(
      {super.key,
      required this.index,
      required this.title,
      required this.subtitle,
      required this.img});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(
              width: 0, color: const Color.fromARGB(255, 255, 255, 255)),
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        //
        child: Row(
          children: [
            Image.asset(img),
            Container(
              width: 16,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 22,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Text(
                          subtitle,
                          maxLines: 1,
                          style: const TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF2ECC71)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
