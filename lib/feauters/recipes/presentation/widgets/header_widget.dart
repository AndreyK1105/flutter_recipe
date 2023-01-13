import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_recipe/feauters/recipes/domain/entities/recipe.dart';

import 'bookmark_icon.dart';

class HeaderWidget extends StatefulWidget {

  Recipe recipe;
   HeaderWidget({super.key, required this.recipe});
   

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
     bool isFavorite =false;

  @override
  Widget build(BuildContext context) {
    return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded (
            child: Text(widget.recipe.name,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
          ),
                  IconButton(icon: const Icon(Icons.favorite), color: (isFavorite)? Colors.red:Colors.black87, onPressed: () {setState(() {
                    if(isFavorite)isFavorite=false; 
                    else isFavorite=true;
                  });   } )
        ],
      ),
      const SizedBox(height: 15),
      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        const Icon(
          Icons.access_time,
          size: 20,
        ),
        const SizedBox(width: 15),
        Expanded(
            child: Text(
          widget.recipe.time,
          style: const TextStyle(color: Color(0xFF2ECC71)),
        ))
      ]),
      const SizedBox(height: 15),
      SizedBox( height: 220,
                width: 396,
        child: Stack(
          children: [
            Container(
                height: 220,
                width: 396,
                child: Image.asset(
                  widget.recipe.img,
                  fit: BoxFit.fitWidth,
                )),
                 const Align(
                      alignment: Alignment.bottomRight ,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 13),
                        child: BookmarkIcon(),
                      )),
          ],
        ),
      ),
            //Image.network(recipe.img),
             
    ],
  );
  }
}