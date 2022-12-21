import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_recipe/screens/listRecipe.dart';
//import 'package:intl/intl.dart';


class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    Route route=_createRoute() ;
Future.delayed(const Duration(milliseconds: 3000), () {

 Navigator.of(context).push(route);
});


    return FutureBuilder<ui.Image>(
        future: loadImage(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            final image = snapshot.data;
            //print(image?.height);

            return Scaffold(
                
                  
                body: 
                
                Container(
                 width: double.infinity, 
                  height: double.infinity,

                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                        ui.Color(0xFF2ECC70),
                        ui.Color(0xFF165932)
                      ])),
                  child: 
                    FittedBox (
                      child: Padding(

                        padding: const EdgeInsets.all(80),
                        child: 
                          SizedBox(width: 250, height: 250,
                            child: Text('OTUS FOOD', 
                               maxLines: 2,

                               strutStyle: StrutStyle( fontFamily: 'Roboto',
                                    fontSize: 70,
                                      height: 0.8,
                                     forceStrutHeight: true,
                                      ),

                              style: TextStyle(
                                fontSize: 70,
                              fontWeight:FontWeight.w700,
                              foreground: Paint()..shader=ImageShader( image!,
                                TileMode.repeated ,
                                TileMode.clamp,
                                Matrix4.identity().storage, ) ),),
                          )


                        // ShaderMask(
                        //   blendMode: BlendMode.srcIn,
                        //   shaderCallback: (Rect bounds) {
                        //     return ImageShader(
                        //       image!,
                        //       TileMode.decal,
                        //       TileMode.decal,
                        //       Matrix4.identity().storage,
                        //     );
                        //     //  RadialGradient(
                        //     //   center: Alignment.center,
                        //     //   radius: 0.5,
                        //     //   colors: <Color>[Colors.yellow, Colors.deepOrange.shade900],
                        //     //   tileMode: TileMode.mirror,
                        //     // ).createShader(bounds);
                        //   },
                        //   child: 
                        
                        //        const SizedBox(width: 200,
                        //          child: Padding(
                        //            padding: EdgeInsets.only(top: 20),
                        //            child: Text(
                        //             'OTUS FOOD',
                                
                        //             strutStyle: StrutStyle( fontFamily: 'Roboto',
                        //             fontSize: 80,
                        //               height: 0.7,
                        //              forceStrutHeight: true,
                        //               ),
                        //             style: TextStyle(
                        //               fontSize: 70,
                                   
                        //                 fontWeight: FontWeight.w900,
                        //                 fontFamily: 'Roboto',
                                     
                        //                 ),
                                        
                                       
                        //       ),
                        //          ),
                        //        ),

                          
                        // ),


                      ),
                    ),
                 
                ));
          }
        });
  }

  Future<ui.Image> loadImage() async {
    final imageBytes = await rootBundle.load('assets/images/back_food.png');


    return decodeImageFromList(imageBytes.buffer.asUint8List());
  }

  void pushPage(context) async{
    await {print('await'), const Duration(seconds: 5), print('await'), Navigator.of(context).push(_createRoute())  };    
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const ListRecipe(),
    transitionDuration: const Duration(milliseconds : 4000),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.easeIn;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        
        position: animation.drive(tween),
        child: child,
      );
    },
  );

}

// Widget text(String text, Image image){
//   return Text(text, style: TextStyle(foreground: Paint()..shader=ImageShader( image,
//                               TileMode.decal,
//                               TileMode.decal,
//                               Matrix4.identity().storage, ) ),);
// }