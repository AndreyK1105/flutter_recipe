import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_recipe/feauters/recipes/data/datasources/data_source_remote.dart';
import 'package:flutter_recipe/feauters/recipes/domain/entities/recipe.dart';
import '../bloc/header_widget_cubit/header_widget_cubit.dart';
import '../bloc/header_widget_cubit/header_widget_state.dart';
import 'bookmark_icon.dart';
import 'package:rive/rive.dart';

class HeaderWidget extends StatefulWidget {
  Recipe recipe;
  String userId;
  HeaderWidget({
    super.key,
    required this.recipe,
    required this.userId,
  });

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
//  bool isFavorite = false;
  late RiveAnimationController _controller;

  ValueNotifier<bool> isFavorite = ValueNotifier<bool>(false);

  DataSourceRemoteImpl dataSourceRemoteImpl = DataSourceRemoteImpl();

  // _controller=OneShotAnimation('bounce',
  @override
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
                color: (context.watch<HeaderWidgetCubit>().state
                        is HeaderWidgetStateLike)
                    ? Colors.red
                    : Colors.black87,
                onPressed: () async {
                  context
                      .read<HeaderWidgetCubit>()
                      .ChangeFavorite(widget.recipe.id, widget.userId);
                  // context
                  //     .read<HeaderWidgetCubit>()
                  //     .getLikeUsersId(widget.recipe.id);
                  //int likes = await dataSourceRemoteImpl.changeLikeCurentUser(
                  //  '63e616f1c337a2bc45fb5b7e', '111');
                  //print('noFavorite= $likes');
                  {
                    isFavorite.value = !isFavorite.value;
                  }
                  ;
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
              SizedBox(
                  height: 220,
                  width: 396,
                  child: Image.network(
                    // 'https://klike.net/uploads/posts/2020-04/1587719791_1.jpg',
                    widget.recipe.img,
                    fit: BoxFit.fitWidth,
                  )),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 13),
                    child: BookmarkIcon(),
                  ))
            ],
          ),
        ),
        //Image.network(recipe.img),
      ],
    );
  }
}
