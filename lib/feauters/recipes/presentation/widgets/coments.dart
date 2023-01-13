import 'package:flutter/material.dart';

class CommentsWidget extends StatefulWidget {
  const CommentsWidget({super.key});

  @override
  State<CommentsWidget> createState() => _CommentsWidgetState();
}

class _CommentsWidgetState extends State<CommentsWidget> {

   late TextEditingController _textEditingController; //=TextEditingController();
       
  
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textEditingController=TextEditingController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _textEditingController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(children: [
    

  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const Expanded(flex: 1, child: CircleAvatar (radius: 31,  backgroundImage: AssetImage( 'assets/images/back_food.png'))),
    Expanded(flex: 3,
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('name'), Text('data')] ),
               const SizedBox(height: 20,),
               const Text ('DescriptionЯ не большой любитель рыбы, но решила приготовить по этому рецепту и просто влюбилась!  '),
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
                        color: const Color(0xFF165932),
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(5)),
                 child: Row(
                 // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                 Expanded(child: Padding(
                  padding: const EdgeInsets.only(left: 14),
                  child: TextField(
                   
                    controller: _textEditingController, 
                    cursorColor: Colors.blue,
                   onSubmitted: (value) => {print(value)},
                     decoration: const InputDecoration(
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