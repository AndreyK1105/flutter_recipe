import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/header_widget_cubit/header_widget_cubit.dart';
import '../bloc/header_widget_cubit/header_widget_state.dart';

class BookmarkIcon extends StatelessWidget {
  const BookmarkIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 66,
      height: 23,
      child: Stack(children: [
        ClipPath(
          clipper: MyCustomCliper(),
          child: Container(
            width: 66,
            height: 23,
            color: const Color(0xFF2ECC71),
          ),
        ),
        Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 7),
              child: likes(context),
            ))
      ]),
    );
  }
}

Widget likes(
  BuildContext context,
) {
  int aggregateLikes = 0;
  var state = context.watch<HeaderWidgetCubit>().state;
  if (state is HeaderWidgetStateLike) {
    aggregateLikes = state.aggregateLikes;
  }
  if (state is HeaderWidgetStateUnLike) {
    aggregateLikes = state.aggregateLikes;
  }
  return Text(
    '$aggregateLikes',
    style: const TextStyle(color: Color.fromARGB(255, 252, 250, 250)),
  );
}

class MyCustomCliper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..lineTo(size.height, size.height / 2)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
