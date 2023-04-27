import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_recipe/feauters/recipes/data/datasources/data_source_remote.dart';
import 'package:flutter_recipe/feauters/recipes/domain/entities/recipe.dart';
import 'package:rive/rive.dart';
import '../bloc/header_widget_cubit/header_widget_cubit.dart';
import '../bloc/header_widget_cubit/header_widget_state.dart';
import '../bloc/like_ikon/like_ikon_cubit.dart';
import 'bookmark_icon.dart';
import 'like_icon.dart';

class HeaderWidget extends StatefulWidget {
  final List<Recipe> recipes;
  final Recipe recipe;
  final String userId;
  const HeaderWidget({
    super.key,
    required this.recipes,
    required this.recipe,
    required this.userId,
  });

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  ValueNotifier<bool> isFavorite = ValueNotifier<bool>(false);

  DataSourceRemoteImpl dataSourceRemoteImpl = DataSourceRemoteImpl();

  SMIInput<bool>? _like;

  void _onInit(Artboard art) {
    final controller =
        StateMachineController.fromArtboard(art, 'State Machine 1');
    //  print('controller ${controller}');
    art.addController(controller!);
    _like = controller.findInput<bool>('Like') as SMIBool;
  }

  // void _changeLike() {
  //   if (_like?.value == false) {
  //     _like?.value = true;
  //   } else {
  //     _like?.value = false;
  //   }
  // }
// Future <void> changeFavorite() async{

//  var d= await  context
//                     .read<HeaderWidgetCubit>()
//                     .changeFavorite(widget.recipe.id, widget.userId);
// }
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

            GestureDetector(
              onTap: () async {
                await context
                    .read<HeaderWidgetCubit>()
                    .changeFavorite(widget.recipe.id, widget.userId);

                context
                    .read<LikeIkonCubit>()
                    .loadLikes(widget.recipes, widget.userId);
              },
              child: LikeIkon(
                recipeId: widget.recipe.id,
                userId: widget.userId,
              ),
            ),

            // Builder(builder: (context) {
            //   bool _isLike;
            //   (context.watch<HeaderWidgetCubit>().state
            //           is HeaderWidgetStateLike)
            //       ? _like?.value = true
            //       : _like?.value = false;
            //   return SizedBox(
            //     height: 50,
            //     width: 50,
            //     child: GestureDetector(
            //       child: RiveAnimation.asset(
            //         'assets/rive/heart.riv',
            //         onInit: _onInit,
            //       ),
            //       onTap: () => context
            //           .read<HeaderWidgetCubit>()
            //           .changeFavorite(widget.recipe.id, widget.userId),
            //     ),
            //   );
            // }),

            // IconButton(
            //     icon: const Icon(Icons.favorite),
            //     color: (context.watch<HeaderWidgetCubit>().state
            //             is HeaderWidgetStateLike)
            //         ? Colors.red
            //         : Colors.black87,
            //     onPressed: () async {
            //       context
            //           .read<HeaderWidgetCubit>()
            //           .changeFavorite(widget.recipe.id, widget.userId);

            //       {
            //         isFavorite.value = !isFavorite.value;
            //       }
            //     })
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
                child: CachedNetworkImage(
                  imageUrl: widget.recipe.img,
                  placeholder: (context, url) => const Padding(
                    padding: EdgeInsets.all(40.0),
                    child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 8, 148, 26),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.fitWidth,
                ),
              ),
              const Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 13),
                    child: BookmarkIcon(),
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
