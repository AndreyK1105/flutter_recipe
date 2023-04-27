import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_recipe/feauters/recipes/presentation/bloc/like_ikon/like_ikon_cubit.dart';
import 'package:rive/rive.dart';

import '../bloc/like_ikon/like_ikon_state.dart';

class LikeIkon extends StatelessWidget {
  final String recipeId;
  final String userId;
  LikeIkon({required this.recipeId, required this.userId, super.key});
  SMIInput<bool>? _like;
  Map<String, bool> likes = {};
  bool _isLike = false;
  void _onInit(Artboard art) {
    final controller =
        StateMachineController.fromArtboard(art, 'State Machine 1');
    //  print('controller ${controller}');
    art.addController(controller!);
    _like = controller.findInput<bool>('Like') as SMIBool;
    _like?.value = _isLike;
  }

  @override
  Widget build(BuildContext context) {
    var state = context.watch<LikeIkonCubit>().state;

    if (state is LikeIkonStatteLoaded) {
      _isLike = state.likes[recipeId] ?? false;

      _like?.value = _isLike;
    }

    return SizedBox(
      height: 50,
      width: 50,
      child: RiveAnimation.asset(
        'assets/rive/heart.riv',
        onInit: _onInit,
      ),
    );
  }
}
