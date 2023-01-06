import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CommentsWidget extends StatefulWidget {
  const CommentsWidget({super.key});

  @override
  State<CommentsWidget> createState() => _CommentsWidgetState();
}

class _CommentsWidgetState extends State<CommentsWidget> {

  TextEditingController textEditingController=TextEditingController();
       
  

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textEditingController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(children: [

  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Expanded(flex: 1, child: CircleAvatar (radius: 31,  backgroundImage: AssetImage( 'assets/images/back_food.png'))),
    Expanded(flex: 3,
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('name'), Text('data')] ),
               const SizedBox(height: 20,),
               Text ('DescriptionЯ не большой любитель рыбы, но решила приготовить по этому рецепту и просто влюбилась!  '),
               const SizedBox(height: 20,),
               SizedBox(
                width: 315, height: 160,
                 child: FittedBox ( fit: BoxFit.values.first ,

                   child: Image.asset('assets/images/recipe_steik.png',
                   // fit: BoxFit.contain,
                    ),
                 ),
               ) ,
               
      ],),
    ) , 
  

  ],),
  const SizedBox(height: 20,),

   Container(
                //width: 400,
                 height:72 ,
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 2,
                        color: Color(0xFF165932),
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(5)),
                 child: Row(
                 // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                const Expanded(child: Padding(
                  padding: EdgeInsets.only(left: 14),
                  child: TextField(
                    cursorColor: Colors.blue,
                     //controller: textEditingController,  
                     decoration: InputDecoration(
                     hintStyle: TextStyle(color: Colors.black) , hintText: 'оставить коментарий'
                      ),
                       ),
                )),
                Padding(
                  padding: const EdgeInsets.only(left: 14, right: 14),
                  child: InkWell(
                          splashColor: Colors.amber,
                    onTap: () => {},
                    child: Image.asset('assets/icons_png/icons8-изображение-96 1.png')),
                ),
                 ]),)  

],);
  }
}