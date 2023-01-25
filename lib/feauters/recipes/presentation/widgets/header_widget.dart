import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_recipe/feauters/recipes/domain/entities/recipe.dart';
import 'bookmark_icon.dart';
import 'package:rive/rive.dart';

class HeaderWidget extends StatefulWidget {
  Recipe recipe;
  HeaderWidget({super.key, required this.recipe});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  bool isFavorite = false;
  late RiveAnimationController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // _controller=OneShotAnimation('bounce',
    // autoplay: false,
    // onStart: () => setState(() {_isPlaying = true;  }),
    // onStop: () => setState(() {_isPlaying= false; }),
    // );
    _controller = SimpleAnimation('idle');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(widget.recipe.name,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w500)),
            ),
            // ***Rive animate***
            // GestureDetector ( onTap: () { setState(() {
            //   print('onPress${_controller.isActive}'); _controller.isActive = !_controller.isActive;
            // });  },
            //     onDoubleTap: (() {
            //       setState(() {
            //          _controller = SimpleAnimation('bouncing');
            //       });
            //     }),

            //  child:  SizedBox(width: 100, height: 100,
            //                      child: RiveAnimation.asset(  'assets/rive/off_road_car.riv',
            //                   // animations: const['idle', 'curves'],
            //                      controllers: [_controller] ,
            //                      onInit: (p0) => setState(() {

            //                      }),),)),

            // ***Rive animate***

            IconButton(
                icon: const Icon(Icons.favorite),
                color: (isFavorite) ? Colors.red : Colors.black87,
                onPressed: () {
                  setState(() {
                    if (isFavorite)
                      isFavorite = false;
                    else
                      isFavorite = true;
                  });
                })
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
        SizedBox(
          height: 220,
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
                  alignment: Alignment.bottomRight,
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
